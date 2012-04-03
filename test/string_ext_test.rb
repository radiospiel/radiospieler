# encoding: utf-8

require 'helper'

class StringExtTest < Test::Unit::TestCase
  def test_html_decode
    assert_equal("a", "a".unhtml)
    assert_equal("ä", "&auml;".unhtml)
  end

  def test_sortkey
    assert_equal("actual", "actual".sortkey)
    assert_equal("schreck003012", "der schreck 3/12".sortkey)
  end
end
