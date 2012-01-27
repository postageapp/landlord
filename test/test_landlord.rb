require 'helper'

class TestLandlord < Test::Unit::TestCase
  def test_module
    assert Landlord

    assert Landlord::VERSION
    assert !Landlord::VERSION.empty?
  end
end
