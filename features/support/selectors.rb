module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.rb
  #
  def selector_for(locator)
    case locator

    when "the header"
      "header"

    when /the "(.+?)" team/
      ["tr", text: $1]

    when /the first rider/
      "#rider_1"

    when /the second rider/
      "#rider_2"

    when /the third rider/
      "#rider_3"

    when /the new lap form/
      "form#new_lap"

    when /lap (\d+)/
      "#lap-times tbody tr:nth-child(#{$1})"

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)
