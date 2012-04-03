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
  
  def get(url, max_age = HTTP.max_age)
    LOGGER.benchmark("[GET] #{url}", :minimum => 20) do 
      Cache.cached(url, max_age) do
        uri = URI(url)
        Net::HTTP.get(uri)
      end
    end
  end
end
