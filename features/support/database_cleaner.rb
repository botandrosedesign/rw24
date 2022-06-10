require 'database_cleaner'
require 'database_cleaner/cucumber'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
Before { load "db/seeds.rb" }

