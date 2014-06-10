Given /^a solo team exists with name: "(.*?)"$/ do |name|
  FactoryGirl.create :team_solo, name: name
end

Given /^a rider exists with name: "(.*?)", team: that team$/ do |name|
  FactoryGirl.create :rider, name: name, team: Team.last
end

Given /^a team exists with name: "(.*?)"$/ do |name|
  FactoryGirl.create :team_a, name: name
end

Then /^(\d+) riders should exist with team: that team$/ do |count|
  team = Team.last
  count.to_i.times do
    FactoryGirl.create :rider, team: team
  end
end

Then "I should see the following leader:" do |table|
  rider = first(".rider + div")
  actual = [rider_to_labels(rider), rider_to_values(rider)]
  table.diff! actual
end

Then "I should see the following riders:" do |table|
  riders = all(".rider + div")[1..-1]
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
  rider.all("input,textarea,select").map(&:value).tap do |values|
    values[-7..-6] = rider.all("input,textarea,select")[-6]["checked"] ? "Yes" : "No"
    values[-4..-2] = values[-4..-2].join("-")
  end
end
