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

def startapp
  require './lib/starshipknights.rb'
  #require 'json'
  File.open(StarshipKnights::Application.config_file_path, "r") do |f|
    $config = JSON.load(f)
  end
  $logger = Logger.new($config["logfile"]) if $config.has_key?("logfile")
  $logger ||= Logger.new(STDOUT)
  loglevel = $config["loglevel"] || "debug"
  configure_logger($logger, loglevel)
  #begin
    a = StarshipKnights::Application.new
    a.show
  #rescue Exception => e
    #$logger.fatal{"Crash in game:\n" + e.message + "\n" + e.backtrace.inspect}
    #raise
  #end
end

#main
startapp