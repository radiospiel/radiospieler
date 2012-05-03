class ImplementationMissing < NameError; end

module Kernel
  private
  
  def abstract_method(*syms)
    syms.each do |sym|
      define_method sym do
        raise ImplementationMissing, "#{self.class.name}##{sym}"
      end
    end
  end
end
