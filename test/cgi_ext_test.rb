# encoding: utf-8

require 'helper'

class CgiExtTest < Test::Unit::TestCase
  def test_url_for
    assert_equal "/abc",              CGI.url_for("/abc")
    assert_equal "/abc?p=12",         CGI.url_for("/abc", :p => 12)
    assert_equal "/abc?a=1&b=1&p=12", CGI.url_for("/abc?a=1&b=1", :p => 12)
    assert_equal "/abc?p=1&p=12",     CGI.url_for("/abc?p=1", :p => 12)
  end

  def test_url_for_escaping
    assert_equal "/abc?p=foo+bar",        CGI.url_for("/abc", :p => "foo bar")
    assert_equal "/abc?p=foo+%3E+bar",    CGI.url_for("/abc", :p => "foo > bar")
    assert_equal "/abc?p=foo+%26+bar",    CGI.url_for("/abc", :p => "foo & bar")
    assert_equal "/abc?p=foo+%C3%A4+bar", CGI.url_for("/abc", :p => "foo ä bar")
  end
end
