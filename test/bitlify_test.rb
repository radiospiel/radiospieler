# encoding: utf-8

require_relative './test_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "#{File.dirname(__FILE__)}/fixtures-vcr"
  c.hook_into :webmock
end

class BitlifyTest < Test::Unit::TestCase
  def test_limit_exceeded
    VCR.use_cassette('bitly_limit_exceeded') do
      assert_equal("http://radiospiel.org/foo", Bitly.shorten("http://radiospiel.org/foo"))
    end
  end

  def test_ok
    VCR.use_cassette('bitly_ok') do
      assert_equal("http://bit.ly/HV7woD", Bitly.shorten("http://radiospiel.org/a=1&b=2"))
    end
  end

  def test_url_base
    expected = "https://api-ssl.bitly.com/v3/shorten?login=bitlyapidemo&apiKey=R_0da49e0a9118ff35f52f629d2d71bf07"
    assert_equal expected,  Bitly.url_base
  end
end
