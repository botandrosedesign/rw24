Given /^a race exists for (\d+)$/ do |year|
  FactoryGirl.create :race, year: year.to_i
end

Then "I should see the following laps:" do |table|
  wait_for_ajax
  actual = all("tr").map do |row|
    row.all("th,td").map(&:text)
  end
  table.diff! actual
end
