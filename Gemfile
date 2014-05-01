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
gem "mail", "2.5.3" # 2.5.4 breaks ssl stuff

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
gem "jquery-rails"
gem "turbo-sprockets-rails3"

group :test, :development do
  gem "quiet_assets"
  gem "byebug"
  gem "rspec-rails"
end

group :test do
  gem "cucumber-rails", :require => false
  gem "poltergeist"
  gem "capybara", "~>1.1"
  gem "database_cleaner"
  gem "pickle"
  gem "email_spec"
  gem "machinist", "~>1.0.6"
  gem "faker"
  gem "delorean"
end

group :production do
  gem "rack-www"
  gem "exception_notification"
end
