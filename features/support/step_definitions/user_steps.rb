Given "the following users exist:" do |table|
  table.create! factory_bot: :user
end

Given "the following user exists:" do |table|
  attributes = Hash[table.raw]
  FactoryBot.create :user, attributes
end

Then "I should see the following users:" do |table|
  table.diff! ".users-table"
end

