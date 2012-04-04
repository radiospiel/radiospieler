# encoding: utf-8

require 'helper'

class HashExtTest < Test::Unit::TestCase
  def test_stringify
    assert_equal({}, {}.stringify_keys)
    assert_equal({ "a" => "a", "b" => "b", "1" => 1 }, { :a => "a", "b" => "b", 1 => 1 }.stringify_keys)
  end

  def test_symbolize
    assert_equal({}, {}.symbolize_keys)
    assert_equal({ :a => "a", :b => "b", 1 => 1 }, { :a => "a", "b" => "b", 1 => 1 }.symbolize_keys)
  end
end
