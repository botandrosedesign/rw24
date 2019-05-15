require './spec/coverage_setup'
require 'cucumber/rails'
require 'capybara/headless_chrome'
require 'capybara-screenshot/cucumber' unless ENV["CI"]

Capybara.register_driver :chrome do |app|
  Capybara::HeadlessChrome::Driver.new(app, window_size: [1600,2400])
end

Capybara::Screenshot.register_driver :chrome do |driver, path|
  driver.save_screenshot(path)
end

Capybara.server = :webrick

# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css

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

