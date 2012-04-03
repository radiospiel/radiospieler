require "htmlentities"

# -- decode HTML entities -----------------------------------------------------

class String
  module HtmlDecoder
    def self.instance
      @htmldecoder ||= HTMLEntities.new
    end
  end

  def unhtml
    HtmlDecoder.instance.decode self
  end
end

# -- convert to UTF8 ----------------------------------------------------------

require 'iconv'
class String
  def to_utf8
    # require "charguess"
    # encoding = CharGuess.guess(self)
    # puts "encoding: #{encoding.inspect}"
    # return self if !encoding || encoding == "UTF-8"

    encoding = 'ISO-8859-1'
    Iconv.conv('utf-8', encoding, self)
  end
end

# -- remove accents -----------------------------------------------------------

require_relative "./string_without_accents"

class String
  include WithoutAccents
end

class String
  def sortkey
    # Convert the key into an sortable ascii string
    self.without_accents.                               # remove accents
      downcase.
      gsub(/^\s*(der|die|das|the|a|ein)\b\s*/, "").     # remove leading stop words
      gsub(/[0-9]+/) { |s| "%03d" % s.to_i }.           # fill in leading zeroes
      gsub(/[^a-z0-9]/, "")                             # keep only letters and digits
  end
end

