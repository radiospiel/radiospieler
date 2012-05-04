# encoding: utf-8

require_relative 'test_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "#{File.dirname(__FILE__)}/fixtures-vcr"
  c.hook_into :webmock
end

class HttpTest < Test::Unit::TestCase
  def test_get_with_redirection
    VCR.use_cassette('http_test') do
      google = Http.get("http://google.de")
      assert google.starts_with?("<!doctype html>")
    end
  end

  def test_get_body_and_headers
    VCR.use_cassette('http_test') do
      body, headers = Http.get("http://google.de", 0)
      assert body.starts_with?("<!doctype html>")
      assert_equal "UTF-8", body.encoding.name
    end
  end

  def test_xml_url
    VCR.use_cassette('http_test', :record => :new_episodes) do
      body, headers = Http.get("http://nowhere.test/9162.xml", 0)
      assert body =~ /Tänzerin/, "Encoding should accept UTF-8 umlauts"
      assert_equal "UTF-8", body.encoding.name
    end
  end

  def test_get_binaty
    VCR.use_cassette('http_test', :record => :new_episodes) do
      body, headers = Http.get_binary("http://nowhere.test/9162.xml", 0)
      assert_equal "ASCII-8BIT", body.encoding.name
    end
  end
end
