Given /^a race exists for (\d+)$/ do |year|
  FactoryBot.create :race, year: year.to_i
end

Given "there are no races" do
  Race.destroy_all
end

Then "I should see the following races:" do |table|
  actual = [all("races li").map(&:text)]
  table.diff! actual
end

