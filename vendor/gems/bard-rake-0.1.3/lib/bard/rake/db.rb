namespace :db do
  desc "Dump the current database to db/data.sql"
  task :dump => :"backup:db" do
    config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    db_file = Dir.glob("../#{config['database'].gsub(/_/, '-')}-*.sql").first
    FileUtils.move db_file, "db/data.sql"
  end

  desc "Load the db/data.sql data into the current database."
  task :load => :environment do
    config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    mysql = `which mysql`.strip
    options  = " -u#{config['username']}"
    options += " -p#{config['password']}" if config['password']
    options += " -h #{config['host']}"    if config['host']

    raise RuntimeError, "I only work with mysql." unless config['adapter'] == 'mysql'
    raise RuntimeError, "Cannot find mysql." if mysql.blank?

    sh "#{mysql} #{options} '#{config["database"]}' < db/data.sql"
  end
end
