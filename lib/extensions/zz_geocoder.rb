require "cgi"
require "json"
require "micro_sql"

# A basic, caching, geocoder
module Geocoder
  extend self
  
  TIME_TO_LIVE = 3600
  
  def geocode(address)
    Geocoder.cached(address) { __geocode__(address) }
  end
  
  private
  
  def __geocode__(address)
    url = "http://maps.google.com/maps/geo?q=#{CGI.escape(address)}&output=json&oe=utf-8"

    json = Http.get(url)
    data = JSON.parse(json)

    status = data["Status"]
    if status["code"] != 200
      STDERR.puts "Geocoding failed for '#{address}' with status #{status["code"]}"
      return
    end
    
    data["Placemark"].first["Point"]["coordinates"]
  end
  
  def self.cached(key, &block)
    @cache ||= MicroSql.create("#{ENV["HOME"]}/geocoder.sqdb").key_value_table("geocache")
    @cache.cached(key, TIME_TO_LIVE, &block)
  end
end
