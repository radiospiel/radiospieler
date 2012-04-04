require 'helper'

class TestConfig < Test::Unit::TestCase
  def test_read_from_test_config
    App.root = File.dirname __FILE__
  
    expected = {"abc"=>"def", "dummy"=>"dummy", "erbed"=> "test" }

    expected.each do |key, expected_value|
       assert_equal(expected_value, App.config[key])
    end

    assert_equal("def", App.config[:abc])
    assert_equal("def", App.config["abc"])
  end
end
