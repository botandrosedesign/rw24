When /^I follow "([^\"]*)" next to "([^\"]*)"$/ do |text, context|
  within "*:contains('#{context}') ~ *:contains('#{text}')" do |scope|
    click_link text
  end
end

Then /^I should see "([^\"]*)" next to "([^\"]*)"$/ do |text, context|
  response.should have_selector "*:contains('#{context}') ~ *:contains('#{text}')"
end

When /^I fill in "([^\"]*)" under "([^\"]*)" with "([^\"]*)"$/ do |field, context, value|
  within "fieldset:contains('#{context}')" do |scope|
    scope.fill_in(field, :with => value)
  end
end

When /^I check "([^\"]*)" under "([^\"]*)"$/ do |field, context|
  within "fieldset:contains('#{context}')" do |scope|
    scope.check(field)
  end
end
