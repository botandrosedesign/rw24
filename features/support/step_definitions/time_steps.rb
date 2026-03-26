Given /^today is "(.+)"$/ do |time|
  Timecop.freeze time
end

When /^I wait for (\d+) seconds?$/ do |seconds|
  Timecop.freeze seconds.to_i.seconds.from_now
  begin
    start_time = Race.last&.start_time
    if start_time
      diff_ms = ((Time.current - start_time) * 1000).to_i
      page.execute_script("window.raceStart = Date.now() - #{diff_ms}")
    end
  rescue Ferrum::Error
    # Browser page not loaded yet
  end
end
