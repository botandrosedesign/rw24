require 'database_cleaner'
require 'database_cleaner/cucumber'

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
ActiveRecord::Base.descendants.each do |model|
  model.shared_connection = model.connection
end

DatabaseCleaner.clean_with :truncation

DatabaseCleaner.strategy = :transaction

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end

