require 'helper'

class TestLandlordConfig < Test::Unit::TestCase
  def test_module
    config = Landlord::Config.new

    assert_equal :apache, config.server_type
  end
end
