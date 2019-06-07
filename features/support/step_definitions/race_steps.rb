Given /^a race exists for (\d+)$/ do |year|
  FactoryBot.create :race, year: year.to_int
end

Given "a race exists for {int} with the following bonus checkpoints:" do |year, table|
  bonuses = table.hashes.map { |hash| { name: hash["Name"], points: hash["Points"].to_i, key: SecureRandom.hex(8) } }
  race = FactoryBot.create :race, year: year.to_i, bonuses: bonuses
end

Given "there are no races" do
  Race.destroy_all
end

Then "I should see the following races:" do |table|
  actual = [all("races li").map(&:text)]
  table.diff! actual
end

Then "I should see the following shirts count:" do |table|
  table.diff! ".shirts-count"
end

