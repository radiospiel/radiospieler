class Module
  def tls(name, &block)
    proc = Proc.new if block_given?
    key = "tls:#{name}"

    define_method(name) do
      Thread.current[key] ||= proc ? proc.call : nil
    end
    
    define_method("#{name}=") do |value|
      Thread.current[key] = value
    end
  end
end
