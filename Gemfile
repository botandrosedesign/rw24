source "https://rubygems.org"
git_source(:github) { |repo_name| "https://github.com/#{repo_name}.git" }

gem "bootsnap", require: false
gem "rails", "~>7.1.0"
gem "trilogy"
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
gem "backhoe"
gem "nacelle"
gem "ckeditor"
gem "kt-paperclip"
gem "adva", github: "botandrose/adva_cms"

gem "delayed_job_active_record"
gem "delayed_job_web"
gem "daemons"
gem "exception_notification"
gem "newrelic_rpm"

gem "sprockets-rails"
gem "dartsass-sprockets"
gem "font-awesome-rails"

gem "importmap-rails", "~>1.0" # 2.0 requires vendoring
gem "stimulus-rails"

group :development do
  gem "bard"
  gem "web-console"
end

group :development, :test do
  gem "byebug"
  gem "parallel_tests", "~>3.9.0" # 3.10 pegs cpu
  gem "sqlite3", "~>1.0" # 2.0 breaks stuff until rails 7.2
  gem "rspec-rails"
end

group :test do
  gem "cucumber-rails", require: false
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
  gem "whenever"
end

