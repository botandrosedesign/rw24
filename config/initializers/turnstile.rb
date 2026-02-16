Cloudflare::Turnstile::Rails.configure do |config|
  if Rails.env.test?
    config.site_key = "1x00000000000000000000AA"
    config.secret_key = "1x0000000000000000000000000000000AA"
  else
    config.site_key = Rails.application.credentials.dig(:turnstile, :site_key)
    config.secret_key = Rails.application.credentials.dig(:turnstile, :secret_key)
  end
end
