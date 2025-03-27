require "exception_notification/rails"

ExceptionNotification.configure do |config|
  # Ignore additional exception types.
  # ActiveRecord::RecordNotFound, AbstractController::ActionNotFound and ActionController::RoutingError are already added.
  # config.ignored_exceptions += %w{ActionView::TemplateError CustomError}

  # Adds a condition to decide when an exception must be ignored or not.
  # The ignore_if method can be invoked multiple times to add extra conditions.
  config.ignore_if do |exception, options|
    not Rails.env.production?
  end

  config.add_notifier :email, {
    email_prefix: "[#{File.basename(Dir.pwd)}] ",
    exception_recipients: "micah@botandrose.com",
    sender_address: "errors@bardtracker.com",
    smtp_settings: Rails.application.credentials.exception_notification_smtp_settings,
  }
end

if defined?(Rake::Application)
  Rake::Application.prepend Module.new {
    def display_error_message error
      ExceptionNotifier.notify_exception(error)
      super
    end

    def invoke_task task_name
      super
    rescue RuntimeError => exception
      if exception.message.starts_with?("Don't know how to build task")
        ExceptionNotifier.notify_exception(exception)
      end
      raise exception
    end
  }
end

class ActiveJob::Base
  rescue_from StandardError do |exception|
    ExceptionNotifier.notify_exception(exception, env: Rails.env, data: {
      job_class: self.class.name,
      job_id: job_id,
      arguments: arguments,
      queue_name: queue_name,
    })
    raise exception
  end
end

Delayed::Worker.prepend Module.new {
  def handle_failed_job job, error
    super
    ExceptionNotifier.notify_exception(error) if job.attempts + 1 == max_attempts(job)
  end
}

