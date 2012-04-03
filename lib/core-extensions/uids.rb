require "digest/md5"
require "forwardable"

class String
  def crc32
    Zlib.crc32(self)
  end

  def md5
    Digest::MD5.hexdigest(self)
  end

  # return a 64 bit uid
  def uid64
    md5.unpack("LL").inject { |a,b| (a << 31) + b }
  end
end

class Hash
  extend Forwardable
  delegate [:uid64, :crc32, :md5] => :calculate_stable_hashable
  
  def calculate_stable_hashable
    map { |k,v| "#{k.inspect}:#{v.inspect}" }.sort.join("//")
  end
end
