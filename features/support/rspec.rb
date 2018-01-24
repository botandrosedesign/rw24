require "rspec/expectations"
require "rspec/core"
RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end

