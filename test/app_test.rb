require 'helper'

class TestMicroSql < Test::Unit::TestCase
  def test_root
    expected = File.expand_path("#{File.dirname(__FILE__)}/..")
    
    assert_equal expected, App::Root.find_starting_in(File.dirname(__FILE__))
    assert_equal expected, App::Root.find
    assert_equal expected, App.root

    App.root = "expected"
    assert_equal "expected", App.root
  end

  def test_object_attributes
    a = {}
    assert_raise(NoMethodError) {  
      a.foo
    }
    
    a.define_attribute :foo, "bar"
    assert_equal("bar", a.foo)

    a.define_attribute :foo, "baz"
    assert_equal("baz", a.foo)

    a.define_attribute :foo, nil
    assert_equal(nil, a.foo)
  end

  def test_benchmark_logger
    r = []
    
    logger = Logger.new(STDERR)
    logger.formatter = proc { |_, _, _, msg| r << msg; nil }
    
    foo = logger.benchmark {
      "foo"
    }
    assert_equal("foo", foo)
    assert_equal(["Benchmark: 0 msecs"], r)

    r = []
    foo = logger.benchmark("message") { "foo" }
    assert_equal("foo", foo)
    assert_equal(["message: 0 msecs"], r)

    r = []
    foo = logger.benchmark("message", :minimum => 1) { "foo" }
    assert_equal("foo", foo)
    assert_equal([], r)
  end
end
