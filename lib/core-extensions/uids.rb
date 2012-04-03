require "digest/md5"

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
