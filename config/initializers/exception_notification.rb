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
    email_prefix: "[riverwest24.com] ",
    exception_recipients: "micah@botandrose.com",
    smtp_settings: Rails.application.credentials[:exception_notification_smtp_settings],
  }
end

Delayed::Worker.prepend Module.new {
  def handle_failed_job job, error
    super
    ExceptionNotifier::Notifier.background_exception_notification(error).deliver if job.attempts + 1 == max_attempts(job)
  end
}

