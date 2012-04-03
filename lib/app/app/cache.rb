require_relative "config"

#
# This is a cache module, which keeps entries for a certain time period, 
# stored away in a redis store.
#
# Entries are packed via Marshal.
module App
  module Cache
    DEFAULT_MAX_AGE = 4 * 3600     # 4 hours.

    attr :store, true
    extend self
    
    def self.clear
      store.flushdb
    end

    def self.cached(key, max_age = DEFAULT_MAX_AGE, &block)
      redis = App::Cache.store
      return yield if !store || !max_age

      if marshalled = store.get(key)
        Marshal.load(marshalled)
      else
        yield.tap { |v| 
          store.set(key, Marshal.dump(v)) 
          store.expire(key, max_age)
        }
      end
    end

    def self.setup
      if !(cache_url = App.config[:cache])
        App.logger.warn "No :cache configuration"
      elsif !(self.store = connect_to_redis(cache_url))
        App.logger.warn "Using cache at #{cache_url}"
      end
    end
    
    def self.connect_to_redis(url)
      require "redis"
      Redis.connect(:url => url)
    rescue LoadError
      App.logger.warn "Cannot load 'redis' gem (connecting to #{url})"
      nil
    end
  end

  def cached(key, max_age = Cache::DEFAULT_MAX_AGE, &block)
    Cache.cached(key, max_age, &block)
  end
end

App::Cache.setup
