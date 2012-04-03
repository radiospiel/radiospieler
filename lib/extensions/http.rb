require 'net/http'

# The Http module defines a 
# 
#   Http.get(url)
#
# method.
module Http
  extend self

  # the default expiration time for get requests.
  attr :max_age
  
  def get(url, max_age = self.max_age)
    App.logger.benchmark("[GET] #{url}", :minimum => 20) do 
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
