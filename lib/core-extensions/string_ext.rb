require "htmlentities"

# -- decode HTML entities -----------------------------------------------------

class String
  @@htmldecoder = HTMLEntities.new

  def decode_html_entities
    @@htmldecoder.decode self
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

require_relative "./without_accents"

class String
  include WithoutAccents

  def sortkey
    # Convert the key into an sortable ascii string
    self.without_accents.                               # remove accents
      downcase.
      gsub(/^\s*(der|die|das|the|a|ein)\b\s*/, "").     # remove leading stop words
      gsub(/[^a-z0-9]/, "").                            # keep only letters and digits
      gsub(/[0-9]+/) { |s| 
        9 > s.length ? s : "0" * (9 - s.length)
      }                            # keep only letters and digits
  end
end

