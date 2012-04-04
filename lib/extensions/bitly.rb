require "cgi"

module Bitly
  TIME_TO_LIVE = 365 * 24 * 3600
  
  def self.url_base
    return @url_base unless @url_base.nil?

    user, key = (App.config[:bitly] || {}).values_at "user", "key"

    @url_base = unless user && key
      App.logger.warn "Missing or invalid bitly configuration: #{App.config[:bitly]}"
      false
    else
      "https://api-ssl.bitly.com/v3/shorten?login=#{user}&apiKey=#{key}"
    end
  end
  
  def self.shorten(url)
    return url if !self.url_base || !url || url.index("/bit.ly/")

    bitly_url = "#{self.url_base}&longUrl=#{CGI.escape(url)}"
    parsed = JSON.parse Http.get(bitly_url, TIME_TO_LIVE) 

    if parsed["status_code"] == 200
      bitlified = parsed["data"]["url"] 
      App.logger.debug "bitlify: #{url} => #{bitlified}"
      bitlified
    else
      App.logger.error "#{url}: bitly error: #{parsed["status_txt"] }"
      url
    end
  end
end
