# Make sure we fix the time up after each scenario
After do
  Timecop.return
  JavaScriptTimecop.return
end
