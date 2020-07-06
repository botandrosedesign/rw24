# prevent mobile safari from reusing stale csrf tokens
Rails.application.config.action_dispatch.default_headers.merge!('Cache-Control' => 'no-store, no-cache')

