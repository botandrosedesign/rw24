When "I select the autocomplete option {string}" do |label|
  find("ul.autocomplete li", text: label).click
end

When "I select and accept the autocomplete option {string} with the following alert dialog:" do |label, dialog|
  # FIXME fix bug in cuprite where asserts modal contents too late
  # accept_alert dialog do
  accept_alert do
    find("ul.autocomplete li", text: label).click
  end
end

Then "I should see the following autocomplete options:" do |table|
  page.document.synchronize Capybara.default_max_wait_time, errors: page.driver.invalid_element_errors + [Capybara::ElementNotFound, Cucumber::MultilineArgument::DataTable::Different] do
    table.diff! "ul.autocomplete"
  end
end
