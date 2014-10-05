#RAILS_ENV  = ENV['RAILS_ENV']  = 'production'
#RAILS_ROOT = ENV['RAILS_ROOT'] = '/home/www/wul_ad'
#PID_DIR    = '/home/www/wul_ad/tmp/pids'
#BIN_PATH   = "/usr/local/rvm/rubies/ruby-2.1.1/bin"
#UID = 'root'
#GID = 'root'

God.watch do |w|
  w.dir      = "#{ADMIN_ROOT}"
  w.name     = "sidekiq_admin"
  w.interval = 30.seconds
  w.group = "admin"
#  w.keepalive(:memory_max => 120.megabytes,
 #             :cpu_max => 20.percent)
  w.start = "cd #{ADMIN_ROOT}; nohup bundle exec sidekiq -e production -C #{ADMIN_ROOT}/config/sidekiq.yml -i 0 -P #{ADMIN_PID_DIR}/sidekiq.pid >> #{ADMIN_ROOT}/log/sidekiq.log 2>&1 &"
  w.stop  = "if [ -d #{ADMIN_ROOT} ] && [ -f #{ADMIN_PID_DIR}/sidekiq.pid ] && kill -0 `cat #{ADMIN_PID_DIR}/sidekiq.pid`> /dev/null 2>&1; then cd #{ADMIN_ROOT} && bundle exec sidekiqctl stop #{ADMIN_PID_DIR}/sidekiq.pid 10 ; else echo 'Sidekiq is not running'; fi"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.keepalive(:memory_max => 130.megabytes,
              :cpu_max => 50.percent)
  w.uid = UID
  #w.gid = GID

  w.pid_file = "#{ADMIN_PID_DIR}/sidekiq.pid"
  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 3
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 2
      c.retry_within = 2.hours
    end
  end
end
