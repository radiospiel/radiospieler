# encoding: utf-8

require_relative 'test_helper'

class StringExtTest < Test::Unit::TestCase
  def test_html_decode
    assert_equal("a", "a".unhtml)
    assert_equal("ä", "&auml;".unhtml)
  end

  def test_sortkey
    assert_equal("actual", "actual".sortkey)
    assert_equal("schreck003012", "der schreck 3/12".sortkey)
  end

  def test_starts_ends_with
    s = "foo bar baz"
    assert s.starts_with?("foo")
    assert !s.starts_with?("baz")
    assert !s.ends_with?("foo")
    assert s.ends_with?("baz")

    assert s.starts_with?("")
    assert s.ends_with?("")
  end
end
