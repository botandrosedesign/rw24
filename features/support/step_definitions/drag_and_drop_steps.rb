When /^I drag (the ".+?" .+?) above (the ".+?" .+?)$/ do |source, destination|
  element_for(source).drag_to element_for(destination)
end

