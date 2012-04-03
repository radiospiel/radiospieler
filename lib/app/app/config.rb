require_relative "root"
require_relative "logger"

require "yaml"

module App
  module Config
    def self.paths
      [ "#{App.root}/config/app.yml", "#{App.root}/config.yml" ]
    end

    def self.read(path)
      return unless File.exist?(path)
      App.logger.info "Reading configuration from #{path}"
      yaml = File.read(path)
      YAML.load(yaml) || {}
    end
    
    def self.load
      config = paths.inject(nil) do |c, path|
        c || read(path)
      end

      config ||= begin
        App.logger.warn "No configuration found in #{App.root}"
        {}
      end
    end

    @@configurations = {}
    
    def self.current
      @@configurations[App.root] ||= begin
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
