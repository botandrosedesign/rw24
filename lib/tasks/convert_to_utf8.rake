namespace :db do
  task :convert_to_utf8 => [:convert_schema, "db:seed"]

  task :convert_schema => :environment do
    config = BardRake.database_config
    options =  " -u #{config["username"]}"
    options += " -p'#{config["password"]}'" if config["password"]
    `mysqldump #{options} -c -e --default-character-set=utf8 --single-transaction --skip-set-charset --add-drop-database -B #{config["database"]} > db/data.original.sql`
    `sed 's/DEFAULT CHARACTER SET latin1/DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci/' < db/data.original.sql | sed 's/DEFAULT CHARSET=latin1/DEFAULT CHARSET=utf8/' > db/data.fixed.sql`
    `mysql #{options} < db/data.fixed.sql`
    ActiveRecord::Base.connection.execute "UPDATE content_translations SET body_html = CONVERT(BINARY CONVERT(body_html USING latin1) USING utf8)"
  end
end
