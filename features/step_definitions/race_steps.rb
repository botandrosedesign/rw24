Given /^a race exists for (\d+)$/ do |year|
  FactoryGirl.create :race, year: year.to_i
end

Then "I should see the following laps:" do |table|
  actual = find("#leader-board").all("tr").map do |row|
    row.all("th,td").map(&:text)
  end
  table.diff! actual
end
