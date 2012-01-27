require 'helper'

class TestLandlordVirtualHost < Test::Unit::TestCase
  def setup
    Landlord.config.template_dir = File.expand_path(
      File.join('..', 'templates'),
      File.dirname(__FILE__)
    )
  end

  def test_simple_config
    virtual_host = Landlord::VirtualHost.new('example.com')
    
    assert virtual_host
    
    assert_equal 'example.com', virtual_host.server_name
    
    expected_conf = expected_result('example_virtual_host.conf')
    
    assert_equal expected_conf, virtual_host.config_file
  end
  
  def test_config_with_aliases
    virtual_host = Landlord::VirtualHost.new('example.com', :aliases => %w[ example.net example.org ])

    expected_conf = expected_result('example_virtual_host_with_aliases.conf')
    
    assert_equal expected_conf, virtual_host.config_file
  end

  def test_config_with_redirects
    virtual_host = Landlord::VirtualHost.new('example.com', :redirects => %w[ example.net example.org ])

    expected_conf = expected_result('example_virtual_host_with_redirects.conf')
    
    assert_equal expected_conf, virtual_host.config_file
  end
end
