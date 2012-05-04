When /^I follow "([^\"]*)" next to "([^\"]*)"$/ do |text, context|
  within "*:contains('#{context}') ~ *:contains('#{text}')" do
    click_link text
  end
end

Then /^I should see "([^\"]*)" next to "([^\"]*)"$/ do |text, context|
  page.should have_css("*:contains('#{context}') ~ *:contains('#{text}')")
end

When /^I fill in "([^\"]*)" under "([^\"]*)" with "([^\"]*)"$/ do |field, context, value|
  within "fieldset:contains('#{context}')" do
    fill_in field, :with => value
  end
end

When /^I check "([^\"]*)" under "([^\"]*)"$/ do |field, context|
  within "fieldset:contains('#{context}')" do
    check(field)
  end
end

When /^I select "([^"]*)" from "([^"]*)" under "([^"]*)"$/ do |value, field, context|
  within "fieldset:contains('#{context}')" do
    select value, :from => field
  end
end

