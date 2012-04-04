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
      App.cached(url, max_age) do 
        App.logger.debug "[GET] #{url}"
        get_(url) 
      end
    end
  end

  private
  
  def get_(uri_str, limit = 10)
    raise 'too many redirections' if limit == 0

    uri = URI.parse(uri_str)
    
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

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
