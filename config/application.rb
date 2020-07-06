require_relative 'boot'

require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rw24
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Central Time (US & Canada)'

    config.action_controller.permit_all_parameters = true

    config.active_record.sqlite3.represent_boolean_as_integer = true

    config.hosts = nil

    class CL
      include Rack::Utils

      def initialize(app)
        @app = app
      end

      def call(env)
        status, headers, body = @app.call(env)
        headers = HeaderHash[headers]
        headers['Content-Length'] = 1000000.to_s

        [status, headers, body]
      end
    end

    config.middleware.insert 0, CL
  end
end
