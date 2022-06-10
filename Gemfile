source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem "bootsnap", require: false
gem "dotenv-rails"
gem "rails", "~>6.0.0"
gem "mysql2"
gem "bard-rake"
gem "bard-static"
gem "bard-staging_banner"
gem "haml-rails"
gem "slim-rails"
gem "decisive"
gem "input_css"
gem "invisible_captcha"
gem "csv_builder"
gem "nokogiri"
gem "acts_as_list"
gem "dynamic_form"
gem "cocoon"
gem "validates_email_format_of"
gem "auto_strip_attributes"
gem "backhoe"
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

gem "sprockets", "~>3.0" # 4.0 requires local changes
gem "sass-rails"
gem "font-awesome-rails"

gem "coffee-rails"
gem "uglifier"
gem "jquery-rails"
gem "jquery-ui-rails"

group :development do
  gem "bard"
  gem "web-console"
end

group :development, :test do
  gem "byebug"
  gem "parallel_tests", "~>3.9.0" # 3.10 pegs cpu
  gem "sqlite3"
  gem "rspec-rails"
  gem "teaspoon-jasmine"
  gem "phantomjs"
end

group :test do
  gem "cucumber-rails", require: false
  gem "cucumber", "~>3.0" # 4.0 breaks CLI runner line option
  gem "diff-lcs", "1.3" # 1.4 breaks #changes
  gem "cuprite", github: "botandrose/cuprite", branch: "drag_and_drop"
  gem "cuprite-downloads"
  gem "capybara-screenshot"
  gem "database_cleaner"
  gem "email_spec"
  gem "factory_bot_rails"
  gem "faker"
  gem "chop"
  gem "timecop"
  gem "coveralls", require: false
end

group :production do
  gem "foreman-export-systemd_user"
  gem "rack-www"
  gem "rack-cache"
  gem "handle_invalid_percent_encoding_requests" # chinese spiders are polluting the internet
end
