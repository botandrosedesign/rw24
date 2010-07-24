Then /^I should see (\d+) teams?$/ do |count|
  response.should have_selector "table.list tbody tr", :count => count.to_i
end

When /^I fill in "([^\"]*)" with "([^\"]*)" for "([^\"]*)"$/ do |field, value, label|
  within racer_selector(label) do
    fill_in field, :with => value
  end
end

When /^I select "([^\"]*)" from "([^\"]*)" for "([^\"]*)"$/ do |value, field, label|
  within racer_selector(label) do
    select value, :from => field
  end
end

When /^I select "([^\"]*)" as the "([^\"]*)" date for "([^\"]*)"$/ do |value, field, label|
  within racer_selector(label) do
    select_date value, :from => field
  end
end

When /^I check "([^\"]*)" for "([^\"]*)"$/ do |field, label|
  within racer_selector(label) do
    check field
  end
end

When /^I uncheck "([^\"]*)" for "([^\"]*)"$/ do |field, label|
  within racer_selector(label) do
    uncheck field
  end
end

def racer_selector(label)
  "h1:contains('#{label}') + *" 
end
