Given /^a rider exists with name: "(.*?)", team: "(.+?)"$/ do |name, team_name|
  FactoryBot.create :rider, name: name, team: Team.find_by_name!(team_name)
end

Then "I should see the following leader:" do |table|
  rider = all(".rider-fields").first
  actual = [rider_to_labels(rider), rider_to_values(rider)]
  table.diff! actual
end

Then "I should see the following riders:" do |table|
  riders = all(".rider-fields")
  actual = [rider_to_labels(riders.first)]
  actual += riders.map do |rider|
    rider_to_values(rider)
  end
  table.diff! actual
end

def rider_to_labels rider
  rider.all("label").map(&:text)
end

def rider_to_values rider
  rider.all("input:not([type=hidden]),textarea").map do |field|
    if field["type"] == "checkbox"
      field.checked? ? "✓" : ""
    else
      field.value
    end
  end
end

Then "I should see {int} rider forms" do |count|
  expect(all(".rider-fields").length).to eq count
end

Then "I should see the {word} rider form filled out with the following:" do |which, table|
  page.document.synchronize Capybara.default_max_wait_time, errors: page.driver.invalid_element_errors + [Capybara::ElementNotFound, Cucumber::MultilineArgument::DataTable::Different] do
    table.diff! all("fieldset.rider-fields").to_a.send(which.to_sym), as: :form
  end
end

