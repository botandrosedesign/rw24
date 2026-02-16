require "vcr"

VCR.configure do |config|
  config.hook_into :webmock
  config.cassette_library_dir = "features/support/vcr_cassettes"
  config.default_cassette_options = { record: :new_episodes }
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = true
  config.ignore_request do |request|
    request.parsed_uri.host != "challenges.cloudflare.com"
  end
end
