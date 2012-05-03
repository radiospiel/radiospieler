# encoding: utf-8

require_relative 'test_helper'

class UriTest < Test::Unit::TestCase
  def test_valid
    assert_equal URI("http://xx.yy/ss"), URI.valid?("http://xx.yy/ss")
    assert_equal false, URI.valid?("an cd")
  end
end
