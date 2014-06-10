Given /^a race exists for (\d+)$/ do |year|
  FactoryGirl.create :race, year: year.to_i
end

