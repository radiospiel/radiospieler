require 'helper'

class TestConfig < Test::Unit::TestCase
  def test_read_from_test_config
    App.root = File.dirname __FILE__
  
    expected = {"abc"=>"def", "dummy"=>"dummy"}
    assert_equal(expected, App.config)
  end
end
