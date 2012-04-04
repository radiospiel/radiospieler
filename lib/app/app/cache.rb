require_relative "config"

#
# This is a cache module, which keeps entries for a certain time period, 
# stored away in a redis store.
#
# Entries are packed via Marshal.
module App
  module Cache
    class SqliteStore < MicroSql::KeyValueTable
      def self.db_path
        @db_path ||= begin
          path = "#{Dir.home}/cache/#{File.basename(App.root)}/a#{App.root.uid64}.sqlite3"
          FileUtils.mkdir_p File.dirname(path)
          path
        end
      end

      def initialize
        @db = MicroSql.create(SqliteStore.db_path)
        super @db, "cache"
      end
      
      alias :get :[]
      alias :set :update
      alias :flushdb :delete_all
    end
    
    DEFAULT_MAX_AGE = 4 * 3600     # 4 hours.

    attr :store, true
    extend self
    
    def self.clear
      store.flushdb
    end

    def self.uid(key)
      case key
      when String, Hash then key.uid64
      when Fixnum       then key
      else
        App.logger.warn "Don't know how to deal with non-uid key #{key}"
        nil
      end 
    end
    
    def self.cached(key, max_age = DEFAULT_MAX_AGE, &block)
      cache_id = uid(key)

      return yield if !store || !max_age || !cache_id

      if marshalled = store.get(cache_id)
        unmarshal(marshalled)
      else
        yield.tap { |v| 
          store.set(cache_id, marshal(v))
          store.expire(cache_id, max_age)
        }
      end
    end

    def self.unmarshal(marshalled)
      Marshal.load Base64.decode64(marshalled) if marshalled
    end
    
    def self.marshal(value)
      Base64.encode64 Marshal.dump(value)
    end
    
    def self.setup
      cache_url = App.config[:cache] || begin
        App.logger.warn "No :cache configuration, fallback to #{SqliteStore.db_path}"
        SqliteStore.db_path
      end
      
      uri = URI.parse(cache_url)

      self.store = case uri.scheme
      when "redis"
        require "redis"
        Redis.connect(:url => cache_url)
      when nil
        SqliteStore.new
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
