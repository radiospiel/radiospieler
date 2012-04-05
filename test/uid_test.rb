# encoding: utf-8

require_relative 'test_helper'

class UidTest < Test::Unit::TestCase
  def test_string_uids
    assert_equal(578656804,                           "actual".crc32)
    assert_equal("5157e3c765af93679ea07052f30f0a6e",  "actual".md5)
    assert_equal(1989069975706612581,                 "actual".uid64)
  end

  def test_hash_uids
    assert_equal(2929690870,                          {1=>1}.crc32)
    assert_equal("d0bd571dc19c083d82f023c9666c5574",  {1=>1}.md5)
    assert_equal(3616698580463597365,                 {1=>1}.uid64)
  end
end
