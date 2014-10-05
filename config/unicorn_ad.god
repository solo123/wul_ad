#RAILS_ENV  = ENV['RAILS_ENV']  = 'production'
#RAILS_ROOT = ENV['RAILS_ROOT'] = '/home/www/wul_ad'
#PID_DIR    = '/home/www/wul_ad/tmp/pids'
#BIN_PATH   = "/usr/local/rvm/rubies/ruby-2.1.1/bin"
#UID = 'root'
#GID = 'root'

God.watch do |w|
  w.dir      = "#{ADMIN_ROOT}"
  w.name     = "unicorn_admin"
  w.interval = 30.seconds
  w.group = "admin"
  w.start   = "cd #{ADMIN_ROOT} && unicorn_rails -c #{ADMIN_ROOT}/config/unicorn.rb -E #{RAILS_ENV} -D"
  w.stop    = "kill -QUIT `cat #{ADMIN_PID_DIR}/unicorn.pid`"
  w.restart = "kill -USR2 `cat #{ADMIN_PID_DIR}/unicorn.pid`"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds

  w.uid = UID
  w.gid = GID

  w.pid_file = "#{ADMIN_PID_DIR}/unicorn.pid"
  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 100.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end

  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
