Before("@turnstile") do
  VCR.insert_cassette("turnstile_pass", allow_playback_repeats: true)
end

After("@turnstile") do |scenario|
  VCR.eject_cassette(skip_no_unused_interactions_assertion: scenario.failed?)
end

Before("@turnstile_reject") do
  VCR.insert_cassette("turnstile_fail")
end

After("@turnstile_reject") do |scenario|
  VCR.eject_cassette(skip_no_unused_interactions_assertion: scenario.failed?)
end
