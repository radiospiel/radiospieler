require_relative 'test_helper'

class CacheTest < Test::Unit::TestCase
  def test_caching
    App::Cache.clear
    
    done = 0

    r = App.cached("six") { done += 1; 2 * 3 }
    assert_equal([1, 6], [done, r])
    
    r = App.cached("six") { done += 1; 2 * 3 }
    assert_equal([1, 6], [done, r])
  end
end
