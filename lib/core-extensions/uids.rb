require "digest/md5"

class String
  def to_crc32
    Zlib.crc32(self)
  end

  def md5
    Digest::MD5.hexdigest(self)
  end

  def to_uid
    md5.unpack("LL").inject { |a,b| (a << 31) + b }
  end
end

class Hash
  def to_uid
    map { |k,v| "#{k.inspect}:#{v.inspect}" }.sort.join("//").to_uid
  end
end
