require "uri"

module URI
  def self.valid?(uri)
    parse(uri)
  rescue URI::InvalidURIError
    false
  end
end

