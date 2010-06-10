# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class StaticHaml
  def self.call(env)

    Dir["app/views/static/**/*"].each do |file|
      next if File.directory?(file)
    
      file.slice! %r{^app/views/static}
      file.slice! %r{\.html\.haml$}

      path = env["PATH_INFO"]
      path = "" if path == "/"

      next unless path == file.sub(%r{/index$}, '')

      env["rack.static_path"] = file
      @controller = StaticController.new
      @controller.instance_eval do
        def assign_names
          @action_name = "dispatch"
        end
      end

      return @controller.process(ActionController::Request.new(env), ActionController::Response.new).to_a
    end

    [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  end
end
