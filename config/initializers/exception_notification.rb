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
      address: ENV["EXCEPTION_NOTIFICATION_SMTP_ADDRESS"],
      port: ENV["EXCEPTION_NOTIFICATION_SMTP_PORT"],
      user_name: ENV["EXCEPTION_NOTIFICATION_SMTP_USER_NAME"],
      password: ENV["EXCEPTION_NOTIFICATION_SMTP_PASSWORD"],
      authentication: :plain,
      ssl: nil,
      tls: nil,
      enable_starttls_auto: true,
    }
  }
end

Delayed::Worker.class_eval do 
  def handle_failed_job_with_exception_notification job, error
    handle_failed_job_without_exception_notification job, error
    ExceptionNotifier::Notifier.background_exception_notification(error).deliver if job.attempts + 1 == max_attempts(job)
  end
  alias_method_chain :handle_failed_job, :exception_notification
end

