# encoding: utf-8

require_relative 'test_helper'

class ImplMissingTest < Test::Unit::TestCase
  abstract_method :an_abstract_method, :another_abstract_method, :not_an_abstract_method

  private
  
  def not_an_abstract_method
    "not_an_abstract_method"
  end

  public
  
  def test_abstract_method
    assert_raise(ImplementationMissing) {  
      an_abstract_method
    }

    begin
      an_abstract_method
      assert false
    rescue ImplementationMissing
      assert true
      assert_equal("ImplMissingTest#an_abstract_method", $!.message)
    end
#    
    assert public_methods.include?(:an_abstract_method)
    assert public_methods.include?(:another_abstract_method)
    assert private_methods.include?(:not_an_abstract_method)
  end
end
