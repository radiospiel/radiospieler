require 'helper'

class CacheTest < Test::Unit::TestCase
  def test_caching
    unless App::Cache.store
      App.logger.warn "No cache configed. Skipping cache tests"
      return
    end
    
    App::Cache.clear
    
    done = 0
    r = App.cached("six") do 
      done += 1
      2 * 3
    end

    assert_equal(6, r)
    
    r = App.cached("six") do 
      done += 1
      2 * 3
    end

    assert_equal(1, done)
    assert_equal(6, r)
  end
end
