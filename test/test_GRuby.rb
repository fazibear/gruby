require File.dirname(__FILE__) + '/test_helper.rb'

class TestGRuby < Test::Unit::TestCase

  def setup
  end
  
  def test_hash
    hash_t = GG::login_hash('GG_HASH_TEST', 12345)
    hash_e = 2990357796
    assert_equal( hash_t, hash_e )
  end
  
end
