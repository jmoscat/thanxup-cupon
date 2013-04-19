rails_env = ENV['RAILS_ENV'] || 'production'

worker_processes (rails_env == 'production' ? 16 : 4)

preload_app true
timeout 90

listen 80