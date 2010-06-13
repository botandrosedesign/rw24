When /^I follow "([^\"]*)" next to "([^\"]*)"$/ do |text, context|
  within "*:contains('#{context}') ~ *:contains('#{text}')" do |scope|
    click_link text
  end
end

Then /^I should see "([^\"]*)" next to "([^\"]*)"$/ do |text, context|
  response.should have_selector "*:contains('#{context}') ~ *:contains('#{text}')"
end

