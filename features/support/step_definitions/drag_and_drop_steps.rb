When /^I drag (the ".+?" .+?) above (the ".+?" .+?)$/ do |source, destination|
  find(*selector_for(source)).drag_to find(*selector_for(destination))
end

