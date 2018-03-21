Then "I should see the following laps:" do |table|
  wait_for_ajax
  table.diff!
end

Then "I should see the following bonuses:" do |table|
  wait_for_ajax
  table.diff! ".bonuses" do
    field(:bonuses) do |cell|
      row_classes = (cell.query_scope[:class] || "").split(" ")
      prefix = row_classes.include?("complete") ? "✓" : "-"
      [prefix, cell.text].join(" ")
    end
  end
end

Then "I should see the following team bonuses:" do |table|
  table.diff!
end

Then "I should see the following bonus checkpoints:" do |table|
  table.diff!
end

