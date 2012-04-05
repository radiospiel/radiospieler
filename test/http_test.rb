# encoding: utf-8

require_relative 'test_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "#{File.dirname(__FILE__)}/fixtures-vcr"
  c.hook_into :webmock
end

class HttpTest < Test::Unit::TestCase
  def test_get
   VCR.use_cassette('http_test') do
      google = Http.get("http://google.de")
      assert google.starts_with?("<!doctype html>")
   end
  end
end
