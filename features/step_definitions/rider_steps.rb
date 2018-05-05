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

Then "I should see the following rider in the riders list:" do |table|
  riders = all(".rider-fields")
  actual = [rider_to_labels(riders.first)]
  actual += riders.map do |rider|
    rider_to_values(rider)
  end
  table.diff! actual, surplus_row: false
end

def rider_to_labels rider
  rider.all("label").map(&:text)
end

def rider_to_values rider
  rider.all("input:not([type=hidden]),textarea").map do |field|
    if field["type"] == "checkbox"
      field.checked? ? "Yes" : "No"
    else
      field.value
    end
  end
end
