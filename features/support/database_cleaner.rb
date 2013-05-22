# encoding: utf-8

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
ActiveRecord::Base.descendants.each do |model|
  model.shared_connection = model.connection
end
 
DatabaseCleaner.clean_with :truncation
load "db/seeds.rb"
