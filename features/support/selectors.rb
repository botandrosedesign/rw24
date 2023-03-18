module WithinHelpers
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

    when "the admin nav"
      "#top"

    when /the "(.+?)" team/
      ["tr", text: $1]

    when /the (first|second|third) rider form/
      all(".rider-field").to_a.send($1.to_sym)

    when /the new lap form/
      "form#new_lap"

    when /lap (\d+)/
      ".lap-times tbody tr:nth-child(#{$1})"

    when /the first lap/
      "#points tr:nth-child(1)"

    when /the admin subnav/
      "#main_menu"

    when /the "(.+?)" (checkpoint|bonus)/
      [".bonuses tr, #bonuses tr", text: $1]

    when /the bonus form/
      "#bonus"

    when /the popup/
      "#cee_box"

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end

  def element_for(locator)
    args = Array(selector_for(locator))
    find(args.shift, **(args.shift || {}))
  end

  def with_scope(locator)
    args = Array(selector_for(locator))
    within(args.shift, **(args.shift || {})) { yield }
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step_fragment, parent|
  with_scope(parent) { step step_fragment }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step_fragment, parent, table_or_string|
  with_scope(parent) { step "#{step_fragment}:", table_or_string }
end

