require 'net/http'
require 'simple_cache'
require 'nokogiri'

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
  
  def get(url, max_age = nil)
    body, headers = get_body_and_headers(url, max_age)
    reencode body, (headers["content-type"] || []).join(";")
  end

  def get_binary(url, max_age = nil)
    body, headers = get_body_and_headers(url, max_age)
    body
  end

  def get_body_and_headers(url, max_age = nil)
    max_age ||= MaxAge.for(url)

    App.logger.benchmark("[GET] #{url}", :minimum => 20) do 
      SimpleCache.cached("f-#{url}", max_age) do 
        App.logger.debug "[GET] #{url}"
        get_body_and_headers_(url) 
      end
    end
  end

  private
  
  def get_body_and_headers_(uri_str, limit = 10)
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
      [ response.body, response.to_hash ]
    when Net::HTTPRedirection then
      location = response['location']
      App.logger.debug "redirected to #{location}"
      get_body_and_headers_(location, limit - 1)
    else  
      [ response.value, nil ]
    end
  end

  def reencode(body, content_type)
    encodings = [ "ISO-8859-1", "UTF-8" ]

    encodings.unshift($1)                   if content_type =~ /; charset=(\S+)/
    encodings.unshift(html_encoding(body))  if content_type =~ /html/
    encodings.unshift(xml_encoding(body))   if content_type =~ /xml/

    force_valid_encoding body, *encodings
  end

  def force_valid_encoding(string, *encodings)
    encodings.each do |enc|
      next unless enc
      begin
        s = string.force_encoding(enc)
        next unless s.valid_encoding?
        return s.encode("UTF-8")
      rescue Encoding::UndefinedConversionError
      end
    end

    nil
  end
  
  def html_encoding(html)
    doc = Nokogiri.HTML(html)
    node = doc.css("meta[http-equiv='Content-Type']").first

    return unless node &&  node["content"] =~ /; charset=(\S+)/
    $1
  end
  
  def xml_encoding(xml)
    Nokogiri.XML(xml).encoding
  end
end
