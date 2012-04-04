# encoding: utf-8

require 'helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "#{File.dirname(__FILE__)}/fixtures-vcr"
  c.hook_into :webmock
end

class GeocoderTest < Test::Unit::TestCase
  def test_geocoder
    VCR.use_cassette('geocoder') do
      expected = [13.40629, 52.524268, 0]
      assert_equal(expected, Geocoder.geocode("Berlin"))
    end
  end
end
