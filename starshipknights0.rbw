require 'logger'

def configure_logger(logger, level)
  case level
    when "debug"
      logger.sev_threshold = Logger::DEBUG
    when "warn"
      logger.sev_threshold = Logger::WARN
    when "info"
      logger.sev_threshold = Logger::INFO
    when "error"
      logger.sev_threshold = Logger::ERROR
    when "fatal"
      logger.sev_threshold = Logger::FATAL
  end
end

def startapp(test)
  if test then
    require './lib/starshipknights.rb'
  else
    require 'starshipknights'
  end
  File.open(StarshipKnights::Application.config_file_path, "r") do |f|
    $config = JSON.load(f)
  end
  $logger = Logger.new($config["logfile"]) if $config.has_key?("logfile")
  $logger ||= Logger.new(STDOUT)
  loglevel = $config["loglevel"] || "debug"
  configure_logger($logger, loglevel)
  if test then
    a = StarshipKnights::Application.new
    a.show
  else
    begin
      a = StarshipKnights::Application.new
      a.show
    rescue Exception => e
      $logger.fatal {e.inspect}
      $logger.fatal {e.backtrace}
    end
  end
end

#main
test = false
prof = false
ARGV.each do |a|
  test = true if a == "test"
  prof = true if a == "prof"
end

if prof then
  require 'profiler'
  Profiler__::start_profile
  startapp(test)
  Profiler__::stop_profile
  File.open("profile.txt", "w") do |f|
    Profiler__::print_profile(f)
  end
else
  startapp(test)
end