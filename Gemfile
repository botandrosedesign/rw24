source "http://rubygems.org"

gem "rails", "~>3.2"
gem "mysql2"
gem "bard-rake"
gem "bard-static"
gem "haml-rails"
gem "input_css"
gem "fastercsv"
gem "csv_builder"
gem "nokogiri"
gem "require_relative"
gem "acts_as_list"
gem "dynamic_form"
gem "validates_email_format_of"
gem "delayed_job_active_record"
gem "delayed_job_web"
gem "delayed_job", "~>3.0"
gem "daemons"
gem "exception_notification"

# path "../adva" do
git "https://github.com/botandrose/adva_cms.git" do
  gem "adva_cms"
  gem "adva_activity"
  gem "adva_rbac"
  gem "adva_user"

  gem "adva_cells"
  gem "adva_fckeditor"
  gem "adva_meta_tags"
end

gem "asset_precompilation_finder"
gem "sass-rails"
gem "compass-rails"
gem "coffee-rails"
gem "uglifier"
gem "jquery-rails", "~>2.2"
gem "turbo-sprockets-rails3"
gem "font-awesome-sass"

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "spring-commands-cucumber"
  gem "spring"
end

group :test, :development do
  gem "quiet_assets"
  gem "byebug"
  gem "rspec-rails"
end

group :test do
  gem "cucumber-rails", :require => false
  gem "poltergeist"
  gem "capybara"
  gem "database_cleaner"
  gem "email_spec"
  gem "factory_girl_rails"
  gem "faker"
  gem "timecop"
end

group :production do
  gem "foreman-export-upstart_user"
  gem "rack-www"
end
