require_relative "config"

#
# This is a cache module, which keeps entries for a certain time period, 
# stored away in a redis store.
#
# Entries are packed via Marshal.
module App
  module Cache
    DEFAULT_MAX_AGE = 5 * 24 * 3600     # 5 days.

    attr :store, true

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
          store.expire(key, ttl)
        }
      end
    end

    def self.setup
      unless cache_url = App.config[:cache]
        App.logger.warn "No :cache configuration"
        return
      end
      
      App.logger.warn "Using cache at #{cache_url}"

      require "redis"

      self.store = Redis.connect(cache_url)
    end
  end

  def cached(key, max_age = DEFAULT_MAX_AGE, &block)
    App::Cache.cached(key, max_age, &block)
  end
end

App::Cache.setup
