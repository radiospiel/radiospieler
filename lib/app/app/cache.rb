require_relative "config"

#
# This is a cache module, which keeps entries for a certain time period, 
# stored away in a redis store.
#
# Entries are packed via Marshal.
module App
  module Cache
    class SqliteStore < MicroSql::KeyValueTable
      def initialize(path)
        FileUtils.mkdir_p "#{Dir.home}/cache/"
        @db = MicroSql.create("#{Dir.home}/cache/#{File.basename(path)}.sqlite3")
        super @db, "cache"
      end

      alias :get :[]
      alias :set :update

      def expire(key, max_age)
        ttl = max_age + Time.now.to_i if max_age
        @db.ask("UPDATE cache SET ttl=? WHERE uid=?", ttl, key)
      end
      
      def flushdb
        @db.exec "DELETE FROM cache"
      end
    end
    
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
      cache_url = App.config[:cache] || begin
        App.logger.warn "No :cache configuration, fallback to ~/cache/radiospiel.sqlite3"
        "#{Dir.home}/cache/radiospiel.sqlite3"
      end
      
      uri = URI.parse(cache_url)

      self.store = case uri.scheme
      when "redis"
        require "redis"
        Redis.connect(:url => cache_url)
      when nil
        SqliteStore.new(uri.path)
      end
    rescue LoadError
      App.logger.warn "LoadError: #{$!}"
      nil
    end
  end

  def cached(key, max_age = Cache::DEFAULT_MAX_AGE, &block)
    Cache.cached(key, max_age, &block)
  end
end

App::Cache.setup
