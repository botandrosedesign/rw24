Rails.application.config.turnstile_site_key ||= Rails.application.credentials.dig(:turnstile, :site_key)
Rails.application.config.turnstile_secret_key ||= Rails.application.credentials.dig(:turnstile, :secret_key)
