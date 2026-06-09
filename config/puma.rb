threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

workers ENV.fetch("WEB_CONCURRENCY") { 2 }

port ENV.fetch("PORT", 3000)
environment ENV.fetch("RAILS_ENV") { "development" }

prune_bundler

state_path "tmp/pids/puma.state"
pidfile    "tmp/pids/puma.pid"
