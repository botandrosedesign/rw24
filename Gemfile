source "http://rubygems.org"

gem "rails", "2.3.8"
gem "rack", "1.1.2" # 1.1.3 breaks webrat?
gem "mysql2", "~>0.2.7"
gem "bard-rake"

gem "haml"
gem "compass", "0.11.1"
gem "compass-querystring_cachebuster"
gem "fastercsv"
gem "csv_builder", "~>1.0"
gem "nokogiri"

group :test, :cucumber do
  gem "ruby-debug"
  gem "autotest-rails"
  gem "rspec-rails", "~>1.3.0"
  gem "machinist", "1.0.6"
  gem "faker", "~>0.3.0"
end

group :cucumber do
  gem "cucumber-rails", "~>0.3.2"
  gem "cucumber", "~>0.10.2"
  gem "database_cleaner"
  gem "capybara", "~>0.4.1.2"
  gem "pickle" # , :git => "http://github.com/botandrose/pickle.git", :branch => "patch-1"
  gem "email_spec", "~>0.6.0"
end
