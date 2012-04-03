
module App
  # -- app root ---------------------------------------------------------------
  
  module Root
    def self.find_starting_in(dir)
      if is_root?(dir)
        dir 
      elsif !dir.sub!(/\/[^\/]+$/, "")
        nil
      else
        find_starting_in(dir)
      end
    end

    def self.is_root?(dir)
      File.exists?("#{dir}/config.ru") || 
      File.exists?("#{dir}/Gemfile") ||
      File.exists?("#{dir}/Procfile")
    end
    
    def self.find
      find_starting_in(Dir.getwd) || raise("Could not find application root for #{dir}")
    end

    def root=(root)
      @root = root
    end

    def root
      @root ||= Root.find.tap { |root| App.logger.warn "Application root is #{root}" }
    end
  end

  extend Root
end
