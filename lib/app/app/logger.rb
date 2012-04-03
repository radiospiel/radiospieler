require "logger"

module App
  def self.logger
    @logger
  end

  def self.logger=(logger)
    logger.formatter = proc { |_, _, _, msg| "*** #{msg}\n" }
    @logger = logger
  end
end

App.logger = Logger.new(STDERR)
