environment ENV['RACK_ENV'] || 'development'
threads ENV['MIN_PUMA_THREADS'] || 0, ENV['MAX_PUMA_THREADS'] || 16
workers ENV['PUMA_WORKERS'] || 1
preload_app!

on_restart do
  ::Redis.current.quit
end

# root = File.expand_path('../..', __FILE__)
# env ||= ENV['RACK_ENV'] || 'development'
#
# if env=='staging'
#   workers (ENV['WEB_CONCURRENCY'] || ENV['PUMA_WORKERS'] || 2).to_i
#   max_threads = (ENV['MAX_THREADS'] || ENV['PUMA_WORKER_THREADS'] || 3).to_i
# else
#   workers (ENV['WEB_CONCURRENCY'] || ENV['PUMA_WORKERS'] || 2).to_i
#   max_threads = (ENV['MAX_THREADS'] || ENV['PUMA_WORKER_THREADS'] || 10).to_i
# end
# threads max_threads / 2, max_threads
#
# preload_app!
#
# rackup DefaultRackup
# port ENV['PORT'] || 3000
# environment env
#
# bind 'unix:///tmp/puma.sock'
#
# pidfile "#{root}/tmp/pids/puma.pid"
#
# stdout_redirect "#{root}/log/puma.stdout.log", "#{root}/log/puma.stderr.log", true
#
# before_fork do
#   ActiveRecord::Base.connection_pool.disconnect!
# end
#
# after_worker_boot do
#   Kernel.rand
#   ActiveSupport.on_load(:active_record) do
#     ActiveRecord::Base.establish_connection
#   end
# end
