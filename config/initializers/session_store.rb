# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_riverwest24_session',
  :secret      => 'b792675611b8f9ff1ca891259fc264a898246502f1366a37c9a893cb71a6ab6d844d4282b1dcf42a9287c4481ced4753bd03abea25da02deae32d09a6977ece7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
