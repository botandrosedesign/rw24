Given /^a race exists for (\d+)$/ do |year|
  Race.make year: year.to_i
end

