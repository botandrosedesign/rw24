Then "I should see the following bonus form:" do |table|
  actual = all("#bonus-form input[type=number], #bonus-form input[type=checkbox]").map do |input|
    label = find("label[for=#{input[:id]}]").text
    value = if input[:type] == "checkbox"
      input.checked? ? "✓" : ""
    else
      input.value
    end
    [label, value]
  end
  table.diff! actual
end

