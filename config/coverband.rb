Coverband.configure do |config|
  config.root              = Dir.pwd
  if defined? Redis
    config.redis           = Redis.new(:url => Figaro.env.REDIS_URL, :db => 1)
  end
  config.coverage_baseline = Coverband.parse_baseline
  config.root_paths        = ['/app/'] # /app/ is needed for heroku deployments
  # regex paths can help if you are seeing files duplicated for each capistrano deployment release
  #config.root_paths       = ['/server/apps/my_app/releases/\d+/']
  config.ignore            = ['vendor']
  # Since rails and other frameworks lazy load code. I have found it is bad to allow
  # initial requests to record with coverband. This ignores first 15 requests
  config.startup_delay     = Rails.env.production? ? 15 : 2
  # Percentage of requests recorded
  config.percentage        = Rails.env.production? ? 30.0 : 100.0

  config.logger            = Rails.logger

  # config options false, true, or 'debug'. Always use false in production
  # true and debug can give helpful and interesting code usage information
  # they both increase the performance overhead of the gem a little.
  # they can also help with initially debugging the installation.
  config.verbose           = Rails.env.production? ? false : true
end