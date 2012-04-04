require 'net/http'

# The Http module defines a 
# 
#   Http.get(url)
#
# method.
module Http
  extend self

  # the default expiration time for get requests.
  module MaxAge
    def self.config
      @config ||= (App.config["cache-max-age"] || {}).to_a
    end
    
    def self.for(url)
      config.each do |pattern, max_age|
        return max_age if url.index(pattern)
      end
      nil
    end
  end
  
  def get(url, max_age = MaxAge.for(url))
    App.logger.benchmark("[GET] #{url}", :minimum => 20) do 
      App.logger.debug "[GET] #{url}"
      App.cached(url, max_age) do get_(url) end
    end
  end

  private
  
  def get_(uri_str, limit = 10)
    raise 'too many redirections' if limit == 0

    response = Net::HTTP.get_response(URI(uri_str))

    case response
    when Net::HTTPSuccess then
      response.body
    when Net::HTTPRedirection then
      location = response['location']
      App.logger.debug "redirected to #{location}"
      get_(location, limit - 1)
    else  
      response.value
    end
  end
end
