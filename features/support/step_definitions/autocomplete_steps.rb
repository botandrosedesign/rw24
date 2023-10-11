When "I select the autocomplete option {string}" do |label|
  find("ul.autocomplete li", text: label).click
end

Then "I should see the following autocomplete options:" do |table|
  page.document.synchronize Capybara.default_max_wait_time, errors: page.driver.invalid_element_errors + [Capybara::ElementNotFound, Cucumber::MultilineArgument::DataTable::Different] do
    table.diff! "ul.autocomplete"
  end
end
