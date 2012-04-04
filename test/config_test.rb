require 'helper'

class TestConfig < Test::Unit::TestCase
  def test_read_from_test_config
    App.root = File.dirname __FILE__
  
    expected = {"abc"=>"def", "dummy"=>"dummy", "erbed"=> "test" }
    assert_equal(expected, App.config)

    assert_equal("def", App.config[:abc])
    assert_equal("def", App.config["abc"])
  end
end
