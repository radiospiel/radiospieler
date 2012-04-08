require "logger"

module App
  def self.logger
    @logger
  end

  if !defined?(INTENDATIONS)
    
  INTENDATIONS = {
    "DEBUG" => '        ',
    "INFO"  => '      **',
    "WARN"  => '    ****',
    "ERROR" => '  ******',
    "FATAL" => '********'
  }
  
  end

  def self.logger=(logger)
    logger.formatter = proc do |severity, datetime, progname, msg| 
      intend = INTENDATIONS[severity] || INTENDATIONS["FATAL"]
      "#{intend} #{msg}\n" 
    end

    @logger = logger
  end
end

App.logger = Logger.new(STDERR)
