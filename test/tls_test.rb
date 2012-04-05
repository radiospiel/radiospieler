# encoding: utf-8

require_relative 'test_helper'

class TlsTest < Test::Unit::TestCase
  thread_local_attribute :tester
  thread_local_attribute :dynamic do  "dynamic" end
  thread_local_attribute :dynamic2 do "dynamic2" end
  
  def test_get_and_set
    assert_equal(nil, TlsTest.tester)
    TlsTest.tester = 1
    assert_equal(1, TlsTest.tester)

    assert_equal("dynamic", TlsTest.dynamic)
  end
  
  def test_thread_locality
    Thread.new {
      assert_equal(nil, TlsTest.tester)
      TlsTest.tester = 1
      assert_equal(1, TlsTest.tester)

      assert_equal("dynamic", TlsTest.dynamic)
    }.join
    
    Thread.new {
      assert_equal(nil, TlsTest.tester)
      TlsTest.tester = 1
      assert_equal(1, TlsTest.tester)

      assert_equal("dynamic", TlsTest.dynamic)
    }.join
  end
end
