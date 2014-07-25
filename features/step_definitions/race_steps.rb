Given /^a race exists for (\d+)$/ do |year|
  FactoryGirl.create :race, year: year.to_i
end

Then "I should see the following laps:" do |table|
  wait_for_ajax
  actual = all("tr").map do |row|
    row.all("th,td").map(&:text)
  end
  table.diff! actual
end

Then "I should see the following bonuses:" do |table|
  wait_for_ajax
  actual = find(".bonuses").all("tr").map do |row|
    prefix = (row[:class] || "").split(" ").include?("complete") ? "✓" : "-"
    rows = row.all("th,td").map(&:text)
    rows[0] = "#{prefix} #{rows[0]}"
    rows
  end
  table.diff! actual
end
