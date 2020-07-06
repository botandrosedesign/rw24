# Michael's machine can't detect html file changes as of Rails 6.0
# TODO find regression
if `hostname`.chomp == "rails-dev-box"
  class Refresh < Struct.new(:app)
    def call(env)
      FileUtils.touch Dir.glob("app/views/**/*")
      app.call(env)
    end
  end

  Rails.application.config.middleware.insert_before 0, Refresh
end

