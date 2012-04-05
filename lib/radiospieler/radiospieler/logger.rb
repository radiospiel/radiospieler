require "logger"

module App
  def self.logger
    @logger
  end

  INTENDATIONS = {
    "DEBUG" => '        ',
    "INFO"  => '      **',
    "WARN"  => '    ****',
    "ERROR" => '  ******',
    "FATAL" => '********'
  }

  def self.logger=(logger)
    logger.formatter = proc do |severity, datetime, progname, msg| 
      intend = INTENDATIONS[severity] || INTENDATIONS["FATAL"]
      "#{intend} #{msg}\n" 
    end

    @logger = logger
  end
end

App.logger = Logger.new(STDERR)
