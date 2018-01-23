source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "dotenv-rails"
gem "rails", "~>4.2.0"
gem "mysql2"
gem "bard-rake"
gem "bard-static"
gem "bard-staging_banner"
gem "haml-rails"
gem "input_css"
gem "fastercsv"
gem "csv_builder"
gem "nokogiri"
gem "acts_as_list"
gem "dynamic_form"
gem "validates_email_format_of"
gem "delayed_job_active_record"
gem "delayed_job_web"
gem "daemons"
gem "exception_notification"
gem "newrelic_rpm"

gem "cells", "~>3.0"
gem "awesome_nested_set", "~> 3.0"
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

gem "sprockets", "~>2.0"
gem "sass-rails", "~>4.0" # have to specify this for some reason
gem "compass", "~>0.12.0"
gem "compass-rails"
gem "coffee-rails"
gem "uglifier"
gem "font-awesome-sass"

gem "jquery-rails", "~>2.2"

group :development do
  gem "bard"
  gem "better_errors"
  gem "binding_of_caller"
end

group :test, :development do
  gem "sqlite3"
  gem "quiet_assets"
  gem "byebug"
  gem "rspec-rails"
  gem "teaspoon-jasmine"
  gem "phantomjs"
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
  gem "coveralls", require: false
end

group :production do
  gem "foreman-export-upstart_user"
  gem "rack-www"
  gem "rack-cache"
  gem "handle_invalid_percent_encoding_requests" # chinese spiders are polluting the internet
end
