Given 'today is "$time"' do |time|
  Delorean.time_travel_to time
end

When /^I wait for (\d+) seconds?$/ do |time|
  sleep(time.to_i)
end

