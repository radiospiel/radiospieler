require 'helper'

class TestMicroSql < Test::Unit::TestCase
  def test_root
    expected = File.expand_path("#{File.dirname(__FILE__)}/..")
    
    assert_equal expected, App::Root.find_starting_in(File.dirname(__FILE__))
    assert_equal expected, App::Root.find
    assert_equal expected, App.root

    App.root = "expected"
    assert_equal "expected", App.root
  end
end
