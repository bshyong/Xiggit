# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_xiggit_session',
  :secret      => '2da0cb004e86b0cacca218e38479b4c9f7ceefd0db097e6a9f2617573afdd99f57808d0d6f726d75cb3cfb40c19a410b7c1c901653cd2e3bf336b21870d56aba'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
