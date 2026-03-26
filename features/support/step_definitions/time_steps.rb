Given /^today is "(.+)"$/ do |time|
  Timecop.freeze time
  JavaScriptTimecop.freeze Time.now
end

When /^I wait for (\d+) seconds?$/ do |seconds|
  Timecop.freeze seconds.to_i.seconds.from_now
  JavaScriptTimecop.freeze Time.now
end
