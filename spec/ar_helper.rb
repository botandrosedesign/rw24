require "bundler/setup" # some deps are pulled from git

require "spec_helper"
require "active_record"
require "database_cleaner"
require "byebug"

$LOAD_PATH << "app/models"

def silence_stream(stream)
  old_stream = stream.dup
  stream.reopen(RbConfig::CONFIG['host_os'] =~ /mswin|mingw/ ? 'NUL:' : '/dev/null')
  stream.sync = true
  yield
ensure
  stream.reopen(old_stream)
  old_stream.close
end

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

# sqlite3 hates our mysql indexes
ActiveRecord::Migration.class_eval do
  def add_index *; end

  def create_table name, **options
    options.delete(:options)
    super
  end

  def add_column (*)
    super
  end
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

# YAML doesn't want to load AS::HashWithIndifferentAccess otherwise
ActiveRecord.use_yaml_unsafe_load = true

