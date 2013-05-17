  Sidekiq.configure_server do |config|
    config.redis = { url:'redis://thanxup-cupon:19032011@pub-redis-12262.eu-west-1-1.2.ec2.garantiadata.com:12262'}
  end

  Sidekiq.configure_client do |config|
    config.redis = { url:'redis://thanxup-cupon:19032011@pub-redis-12262.eu-west-1-1.2.ec2.garantiadata.com:12262' }
  end
