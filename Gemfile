source "http://rubygems.org"

gem "rails"
gem "mysql2"
gem "bard-rake"
gem "bard_static"
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

# path "../adva" do
git "https://github.com/botandrose/adva_cms.git", :branch => "revamp" do
  gem "adva_cms"
  gem "adva_rbac"
  gem "adva_user"
  gem "adva_activity"

  gem "adva_cells"
  gem "adva_fckeditor"
  gem "adva_meta_tags"
end

gem "asset_precompilation_finder"
gem "sass-rails"
gem "compass-rails"
gem "coffee-rails"
gem "coffee-filter"
gem "therubyracer"
gem "uglifier"
gem "jquery-rails"

group :test, :development do
  gem "pry"
  gem "ruby18_source_location"
  gem "ruby-debug"

  gem "rspec-rails"
end

group :test do
  gem "spork-rails"
  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "pickle"
  gem "email_spec"
  gem "machinist", "~>1.0.6"
  gem "faker"
end

group :production do
  gem "foreman"
  gem "rack-www"
  gem "exception_notification"
end
