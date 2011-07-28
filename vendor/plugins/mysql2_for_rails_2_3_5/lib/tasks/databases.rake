# OverrideRakeTask - based on https://github.com/eugenebolshakov/override_rake_task
Rake::TaskManager.class_eval do
  def alias_task(old_name, new_name)
    @tasks[Rake::Task.scope_name(@scope, new_name)] = 
          @tasks.delete(Rake::Task.scope_name(@scope, old_name))
  end
end

def alias_task(old_name, new_name)
  Rake.application.alias_task(old_name, new_name)
end

def override_task(*args, &block)
  name, params, deps = Rake.application.resolve_args(args.dup)
  alias_task name.to_s, "#{name}:original"
  Rake::Task.define_task(*args, &block)
end



# based on https://github.com/rails/rails/blob/v2.3.5/railties/lib/tasks/databases.rake

namespace :db do
  def create_database(config)
    begin
      if config['adapter'] =~ /sqlite/
        if File.exist?(config['database'])
          $stderr.puts "#{config['database']} already exists"
        else
          begin
            # Create the SQLite database
            ActiveRecord::Base.establish_connection(config)
            ActiveRecord::Base.connection
          rescue
            $stderr.puts $!, *($!.backtrace)
            $stderr.puts "Couldn't create database for #{config.inspect}"
          end
        end
        return # Skip the else clause of begin/rescue    
      else
        ActiveRecord::Base.establish_connection(config)
        ActiveRecord::Base.connection
      end
    rescue
      case config['adapter']
      when /mysql/
        @charset   = ENV['CHARSET']   || 'utf8'
        @collation = ENV['COLLATION'] || 'utf8_unicode_ci'
        begin
          ActiveRecord::Base.establish_connection(config.merge('database' => nil))
          ActiveRecord::Base.connection.create_database(config['database'], :charset => (config['charset'] || @charset), :collation => (config['collation'] || @collation))
          ActiveRecord::Base.establish_connection(config)
        rescue
          $stderr.puts "Couldn't create database for #{config.inspect}, charset: #{config['charset'] || @charset}, collation: #{config['collation'] || @collation} (if you set the charset manually, make sure you have a matching collation)"
        end
      when 'postgresql'
        @encoding = config[:encoding] || ENV['CHARSET'] || 'utf8'
        begin
          ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
          ActiveRecord::Base.connection.create_database(config['database'], config.merge('encoding' => @encoding))
          ActiveRecord::Base.establish_connection(config)
        rescue
          $stderr.puts $!, *($!.backtrace)
          $stderr.puts "Couldn't create database for #{config.inspect}"
        end
      end
    else
      $stderr.puts "#{config['database']} already exists"
    end
  end

  desc "Retrieves the charset for the current environment's database"
  override_task :charset => :environment do
    config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    case config['adapter']
    when /mysql/
      ActiveRecord::Base.establish_connection(config)
      puts ActiveRecord::Base.connection.charset
    when 'postgresql'
      ActiveRecord::Base.establish_connection(config)
      puts ActiveRecord::Base.connection.encoding
    else
      puts 'sorry, your database adapter is not supported yet, feel free to submit a patch'
    end
  end

  desc "Retrieves the collation for the current environment's database"
  override_task :collation => :environment do
    config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    case config['adapter']
    when /mysql/
      ActiveRecord::Base.establish_connection(config)
      puts ActiveRecord::Base.connection.collation
    else
      puts 'sorry, your database adapter is not supported yet, feel free to submit a patch'
    end
  end

  namespace :structure do
    desc "Dump the database structure to a SQL file"
    override_task :dump => :environment do
      abcs = ActiveRecord::Base.configurations
      case abcs[RAILS_ENV]["adapter"]
      when /mysql/, "oci", "oracle"
        ActiveRecord::Base.establish_connection(abcs[RAILS_ENV])
        File.open("#{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql", "w+") { |f| f << ActiveRecord::Base.connection.structure_dump }
      when "postgresql"
        ENV['PGHOST']     = abcs[RAILS_ENV]["host"] if abcs[RAILS_ENV]["host"]
        ENV['PGPORT']     = abcs[RAILS_ENV]["port"].to_s if abcs[RAILS_ENV]["port"]
        ENV['PGPASSWORD'] = abcs[RAILS_ENV]["password"].to_s if abcs[RAILS_ENV]["password"]
        search_path = abcs[RAILS_ENV]["schema_search_path"]
        search_path = "--schema=#{search_path}" if search_path
        `pg_dump -i -U "#{abcs[RAILS_ENV]["username"]}" -s -x -O -f db/#{RAILS_ENV}_structure.sql #{search_path} #{abcs[RAILS_ENV]["database"]}`
        raise "Error dumping database" if $?.exitstatus == 1
      when "sqlite", "sqlite3"
        dbfile = abcs[RAILS_ENV]["database"] || abcs[RAILS_ENV]["dbfile"]
        `#{abcs[RAILS_ENV]["adapter"]} #{dbfile} .schema > db/#{RAILS_ENV}_structure.sql`
      when "sqlserver"
        `scptxfr /s #{abcs[RAILS_ENV]["host"]} /d #{abcs[RAILS_ENV]["database"]} /I /f db\\#{RAILS_ENV}_structure.sql /q /A /r`
        `scptxfr /s #{abcs[RAILS_ENV]["host"]} /d #{abcs[RAILS_ENV]["database"]} /I /F db\ /q /A /r`
      when "firebird"
        set_firebird_env(abcs[RAILS_ENV])
        db_string = firebird_db_string(abcs[RAILS_ENV])
        sh "isql -a #{db_string} > #{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql"
      else
        raise "Task not supported by '#{abcs["test"]["adapter"]}'"
      end

      if ActiveRecord::Base.connection.supports_migrations?
        File.open("#{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql", "a") { |f| f << ActiveRecord::Base.connection.dump_schema_information }
      end
    end
  end

  namespace :test do
    desc "Recreate the test databases from the development structure"
    override_task :clone_structure => [ "db:structure:dump", "db:test:purge" ] do
      abcs = ActiveRecord::Base.configurations
      case abcs["test"]["adapter"]
      when /mysql/
        ActiveRecord::Base.establish_connection(:test)
        ActiveRecord::Base.connection.execute('SET foreign_key_checks = 0')
        IO.readlines("#{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql").join.split("\n\n").each do |table|
          ActiveRecord::Base.connection.execute(table)
        end
      when "postgresql"
        ENV['PGHOST']     = abcs["test"]["host"] if abcs["test"]["host"]
        ENV['PGPORT']     = abcs["test"]["port"].to_s if abcs["test"]["port"]
        ENV['PGPASSWORD'] = abcs["test"]["password"].to_s if abcs["test"]["password"]
        `psql -U "#{abcs["test"]["username"]}" -f #{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql #{abcs["test"]["database"]}`
      when "sqlite", "sqlite3"
        dbfile = abcs["test"]["database"] || abcs["test"]["dbfile"]
        `#{abcs["test"]["adapter"]} #{dbfile} < #{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql`
      when "sqlserver"
        `osql -E -S #{abcs["test"]["host"]} -d #{abcs["test"]["database"]} -i db\\#{RAILS_ENV}_structure.sql`
      when "oci", "oracle"
        ActiveRecord::Base.establish_connection(:test)
        IO.readlines("#{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql").join.split(";\n\n").each do |ddl|
          ActiveRecord::Base.connection.execute(ddl)
        end
      when "firebird"
        set_firebird_env(abcs["test"])
        db_string = firebird_db_string(abcs["test"])
        sh "isql -i #{RAILS_ROOT}/db/#{RAILS_ENV}_structure.sql #{db_string}"
      else
        raise "Task not supported by '#{abcs["test"]["adapter"]}'"
      end
    end

    desc "Empty the test database"
    override_task :purge => :environment do
      abcs = ActiveRecord::Base.configurations
      case abcs["test"]["adapter"]
      when /mysql/
        ActiveRecord::Base.establish_connection(:test)
        ActiveRecord::Base.connection.recreate_database(abcs["test"]["database"], abcs["test"])
      when "postgresql"
        ActiveRecord::Base.clear_active_connections!
        drop_database(abcs['test'])
        create_database(abcs['test'])
      when "sqlite","sqlite3"
        dbfile = abcs["test"]["database"] || abcs["test"]["dbfile"]
        File.delete(dbfile) if File.exist?(dbfile)
      when "sqlserver"
        dropfkscript = "#{abcs["test"]["host"]}.#{abcs["test"]["database"]}.DP1".gsub(/\\/,'-')
        `osql -E -S #{abcs["test"]["host"]} -d #{abcs["test"]["database"]} -i db\\#{dropfkscript}`
        `osql -E -S #{abcs["test"]["host"]} -d #{abcs["test"]["database"]} -i db\\#{RAILS_ENV}_structure.sql`
      when "oci", "oracle"
        ActiveRecord::Base.establish_connection(:test)
        ActiveRecord::Base.connection.structure_drop.split(";\n\n").each do |ddl|
          ActiveRecord::Base.connection.execute(ddl)
        end
      when "firebird"
        ActiveRecord::Base.establish_connection(:test)
        ActiveRecord::Base.connection.recreate_database!
      else
        raise "Task not supported by '#{abcs["test"]["adapter"]}'"
      end
    end
  end
end

def drop_database(config)
  case config['adapter']
  when /mysql/
    ActiveRecord::Base.establish_connection(config)
    ActiveRecord::Base.connection.drop_database config['database']
  when /^sqlite/
    FileUtils.rm(File.join(RAILS_ROOT, config['database']))
  when 'postgresql'
    ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
    ActiveRecord::Base.connection.drop_database config['database']
  end
end
