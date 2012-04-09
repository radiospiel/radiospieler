require "simple_cache"

module SimpleCache
  def self.fallback_url
    "#{File.basename(App.root)}/a#{App.root.uid64}".tap { |name|
      App.logger.warn "No, invalid, or unsupported :cache configuration, fallback to #{name}"
    }
  end
end

SimpleCache.url = App.config[:cache] || SimpleCache.fallback_url
