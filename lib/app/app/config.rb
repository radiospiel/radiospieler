require_relative "root"
require_relative "logger"

require "yaml"

module App
  module Config
    def self.path
      "#{App.root}/config/app.yml"
    end
    
    def self.load
      YAML.load File.read(path)
    rescue Errno::ENOENT
      App.logger.warn "No configuration found in #{path}"
    end
    
    def self.current
      @current ||= begin
        config = self.load
        default_settings = config["default"] || {}
        current_settings = config[App.env] || {}
        default_settings.update current_settings
      end
    end
  end

  def config
    Config.current
  end
end
