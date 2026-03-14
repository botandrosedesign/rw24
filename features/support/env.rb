require 'cucumber/rails'
require "capybara/cuprite"
require "cuprite/downloads/cucumber"
require 'capybara-screenshot/cucumber' unless ENV["CI"]

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(app, {
    window_size: [1200, 2048],
    timeout: 20,
    process_timeout: 20,
    js_errors: true,
    logger: FerrumLogger.new,
    # headless: false,
  })
end

class FerrumLogger
  def puts(log_str)
    return if log_str.nil?

    _log_symbol, _log_time, log_body_str = log_str.to_s.strip.split(' ', 3)

    return if log_body_str.nil?

    begin
      log_body = JSON.parse(log_body_str)
    rescue JSON::ParserError
      return Kernel.puts log_body_str
    end

    case log_body['method']
    when 'Runtime.consoleAPICalled'
      log_body['params']['args'].each do |arg|
        case arg['type']
        when 'string'
          Kernel.puts arg['value']
        when 'object'
          Kernel.puts arg['preview']['properties'].map { |x| [x["name"], x["value"]] }.to_h
        end

      end

    when 'Runtime.exceptionThrown'
      # noop, this is already logged because we have "js_errors: true" in cuprite.

    when 'Log.entryAdded'
      Kernel.puts "#{log_body['params']['entry']['url']} - #{log_body['params']['entry']['text']}"
    end
  end
end

Capybara.server = :puma, { Silent: true }
Capybara.default_driver = :cuprite
Capybara.default_normalize_ws = true

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how 
# your application behaves in the production environment, where an error page will 
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

I18n.enforce_available_locales = false

