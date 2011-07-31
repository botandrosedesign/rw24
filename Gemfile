source "http://rubygems.org"

gem "rails", "2.3.4"
gem "mysql2", "~>0.2.7"
gem "bard-rake", :require => false
gem "ruby-debug", :group => [:development, :test, :cucumber]

gem "haml"
gem "compass", "0.11.1"
gem "compass-querystring_cachebuster"
gem "fastercsv"
gem "csv_builder", "~>1.0"
gem "nokogiri"

gem "rspec",       "1.2.9", :require => false
gem "rspec-rails", "1.2.9", :require => false

group :test, :cucumber do
  gem "autotest-rails"
  gem "machinist",   "1.0.6", :require => false
  gem "faker",       "0.3.1"
end

group :cucumber do
  gem "cucumber",    "0.4.3", :require => false
  gem "webrat",      "0.5.3", :require => false
  gem "pickle",      "0.3.0", :require => false
  gem "email_spec",  "0.4.0"
  gem "mechanize"
end
