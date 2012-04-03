require "cgi"

class CGI
  def self.url_for(url, params = nil)
    return url unless params
    params = params.map { |k,v| "#{k}=#{CGI.escape(v.to_s)}" }.join("&")
    url.index("?") ? "#{url}&#{params}" : "#{url}?#{params}"
  end
end
