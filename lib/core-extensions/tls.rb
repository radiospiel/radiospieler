class Module
  def thread_local_attribute(name, &block)
    proc = Proc.new if block_given?
    key = "tls:#{name}"

    singleton_class.class_eval do
      define_method(name) do
        Thread.current[key] ||= proc ? proc.call : nil
      end

      define_method("#{name}=") do |value|
        Thread.current[key] = value
      end
    end
  end
end
