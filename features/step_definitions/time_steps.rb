Given 'today is "$time"' do |time|
  Timecop.freeze time
end

When /^I wait for (\d+) seconds?$/ do |seconds|
  Timecop.freeze seconds.to_i.seconds.from_now
end

