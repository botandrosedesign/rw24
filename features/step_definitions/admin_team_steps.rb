Then /^I should see (\d+) teams?$/ do |count|
  response.should have_selector "table.list tbody tr", :count => count.to_i
end
