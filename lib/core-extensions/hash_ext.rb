require "forwardable"

class Hash
  def stringify_keys
    r = []
    each { |k,v| r << k.to_s << v }
    Hash[*r]
  end

  def symbolize_keys
    r = []
    each { |k,v| r << k.to_sym << v }
    Hash[*r]
  end
end

class Hash
  extend Forwardable
  delegate [:uid64, :crc32, :md5] => :calculate_stable_hashable
  
  def calculate_stable_hashable
    map { |k,v| "#{k.inspect}:#{v.inspect}" }.sort.join("//")
  end
end
