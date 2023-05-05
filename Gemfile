source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem "bootsnap", require: false
gem "rails", "~>7.0.4"
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
gem "cocoon"
gem "validates_email_format_of"
gem "auto_strip_attributes"
gem "awesome_nested_set"
gem "active_record-json_associations"
gem "nacelle"
gem "ckeditor"
gem "image_processing"
gem "adva", github: "botandrose/adva_cms", branch: "integrate-ckeditor"

gem "delayed_job_active_record"
gem "delayed_job_web"
gem "daemons"
gem "exception_notification"
gem "newrelic_rpm"

gem "sass-rails"
gem "font-awesome-rails"

gem "jquery-rails"
gem "jquery-ui-rails"

gem "importmap-rails"
gem "stimulus-rails"

group :development do
  gem "bard"
  gem "web-console"
end

group :development, :test do
  gem "byebug"
  gem "parallel_tests", "~>3.9.0" # 3.10 pegs cpu
  gem "sqlite3"
  gem "rspec-rails"
end

group :test do
  gem "cucumber-rails", require: false
  gem "cucumber", require: false, github: "botandrose/cucumber", branch: "restore_looser_line_numbers"
  gem "cuprite", github: "botandrose/cuprite", branch: "drag_and_drop"
  gem "cuprite-downloads"
  gem "puma"
  gem "capybara-screenshot"
  gem "database_cleaner"
  gem "email_spec"
  gem "factory_bot_rails"
  gem "faker"
  gem "chop"
  gem "timecop"
end

group :production do
  gem "foreman-export-systemd_user"
  gem "rack-www"
  gem "rack-cache"
  gem "rack-tracker", github: "botandrose/rack-tracker", branch: "ga4"
end

