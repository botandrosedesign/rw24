require "spec_helper"
require "active_record"
require "database_cleaner"
require "byebug"

$LOAD_PATH << "app/models"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

# sqlite3 hates our mysql indexes
ActiveRecord::Migration.class_eval do
  def add_index *; end
end

DatabaseCleaner.strategy = :transaction
silence_stream(STDOUT) do
  load "db/schema.rb"
end

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# silence deprecation warning
I18n.enforce_available_locales = true

