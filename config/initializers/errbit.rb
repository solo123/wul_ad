Airbrake.configure do |config|
  config.api_key = '283c842ed955b77fa71590f6b32d43df'
  config.host    = '127.0.0.1'
  config.port    = 3002
  config.secure  = config.port == 443
  config.development_environments = []
end