# encoding: utf-8

require 'helper'

class ArrayExtTest < Test::Unit::TestCase
  def test_extract_options
    array = [ 1, 2, 3 ]
    options = array.extract_options!
    assert_equal({}, options)
    assert_equal([1,2,3], array)

    array = [ ]
    options = array.extract_options!
    assert_equal({}, options)
    assert_equal([], array)

    array = [ 1, 2, 3, {} ]
    options = array.extract_options!
    assert_equal({}, options)
    assert_equal([1,2,3], array)

    array = [ {} ]
    options = array.extract_options!
    assert_equal({}, options)
    assert_equal([], array)

    array = [ 1, 2, 3, { 1 => 2 } ]
    options = array.extract_options!
    assert_equal({ 1 => 2 }, options)
    assert_equal([1,2,3], array)

    array = [ { 1 => 2 } ]
    options = array.extract_options!
    assert_equal({ 1 => 2 }, options)
    assert_equal([], array)
  end
end
