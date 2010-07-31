source "http://rubygems.org"

gem "rails", "2.3.4"
gem "ruby-mysql"
gem "bard-rake", :require => false
gem "ruby-debug", :group => [:development, :test, :cucumber]

gem "haml", "~>2.2"
gem "compass", "~>0.8"
gem "fastercsv"

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
