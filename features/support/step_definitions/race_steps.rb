Given /^a race exists for (\d+)$/ do |year|
  FactoryBot.create :race, year: year.to_int
end

Given "a race exists for {int} with the following categories:" do |year, table|
  categories = table.raw.flatten.map { |name| TeamCategory.find_by_name!(name) }
  FactoryBot.create :race, year: year, categories: categories
end

Given "a race exists for {int} with the following bonus checkpoints:" do |year, table|
  race = FactoryBot.create :race, year: year.to_i
  table.hashes.each do |hash|
    race.bonuses.create!(name: hash["Name"], points: hash["Points"].to_i, key: SecureRandom.hex(8))
  end
end

Given "there are no races" do
  Race.destroy_all
end

Then "I should see the following categories:" do |table|
  table.diff! ".categories"
end

Then "I should see the following races:" do |table|
  table.diff! ".race-list"
end

Then "I should see the following shirts count:" do |table|
  table.diff! ".shirts-count"
end

