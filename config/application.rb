require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rw24
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Central Time (US & Canada)'

    config.action_controller.permit_all_parameters = true

    config.hosts = nil

    # YAML doesn't want to load AS::HashWithIndifferentAccess otherwise
    config.active_record.use_yaml_unsafe_load = true
  end
end
