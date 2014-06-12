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
    sender_address: %{"smtp" <smtp@riverwest24.com>},
    exception_recipients: "micah@botandrose.com",
    smtp_settings: {
      address: "smtp.gmail.com",
      port: 587,
      authentication: :plain,
      user_name: "errors@botandrose.com",
      password: "***REMOVED***",
      ssl: nil,
      tls: nil,
      enable_starttls_auto: true,
    }
  }
end

ActionController::Live.class_eval do
  def log_error_with_exception_notification(exception)
    ExceptionNotifier.notify_exception(exception, env: request.env)
    log_error_without_exception_notification(exception)
  end
  alias_method_chain :log_error, :exception_notification
end

Delayed::Worker.class_eval do 
  def handle_failed_job_with_exception_notification job, error
    handle_failed_job_without_exception_notification job, error
    ExceptionNotifier::Notifier.background_exception_notification(error).deliver if job.attempts + 1 == max_attempts(job)
  end
  alias_method_chain :handle_failed_job, :exception_notification
end

