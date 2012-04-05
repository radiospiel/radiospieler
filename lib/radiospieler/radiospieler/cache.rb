require_relative "config"
require "simple_cache"

# This is a cache module, which keeps entries for a certain time period (or forever).
#
# Entries are packed via Marshal.
module App
  module Cache
    DEFAULT_MAX_AGE = 4 * 3600     # 4 hours.

    def self.store
      @store ||= Store.create(App.config[:cache]) || Store.fallback
    end

    def self.store=(store)
      @store = store
    end

    def self.clear
      store.clear
    end
    
    module Store
      def self.create(url)
        return unless url
        
        uri = URI.parse(url)
        case uri.scheme
        when "redis"  then RedisStore.new(url)
        when nil      then ::SimpleCache.new(uri.path)
        end
      end
      
      def self.fallback
        name = "#{File.basename(App.root)}/a#{App.root.uid64}"
        SimpleCache.new(name).tap do |store|
          App.logger.warn "No, invalid, or unsupported :cache configuration, fallback to #{store.path}"
        end
      end
    end

    class Store::RedisStore
      def initialize(url)
        require "redis"
        @redis = Redis.connect(:url => url)
      end

      include SimpleCache::Marshal
      
      def keys
        @redis.keys
      end
      
      def clear
        @redis.flushdb
        #debugger
        1
      end
      
      def store(key, value, max_age = DEFAULT_MAX_AGE)
        cache_id = uid(key)
        if value
          @redis.set cache_id, marshal(value)
          @redis.expire cache_id, max_age if max_age
        else
          @redis.del cache_id
        end
        value
      end
      
      def fetch(key, &block)
        marshalled = @redis.get(uid(key))
        marshalled ? unmarshal(marshalled) : yield
      end
    end
  end

  def cached(key, max_age = Cache::DEFAULT_MAX_AGE, &block)
    return yield if !max_age

    cache_store = Cache.store
    cache_store.fetch(key) do
      cache_store.store(key, yield, max_age)
    end
  end
end
