require 'helper'

class TestMicroSql < Test::Unit::TestCase
  def test_assert_creation_with_unsupported_url
    assert_raise(NameError) {  
      MicroSql.create "xy://abc"
    }
  end
end
