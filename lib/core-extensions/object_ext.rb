class Object
  private
  
  def define_attribute(sym, value)
    (class << self; self; end).class_eval do
      define_method(sym) { value }
    end
    value
  end
end
