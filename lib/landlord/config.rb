require 'ostruct'

class Landlord::Config < OpenStruct
  # == Constants ============================================================
  
  DEFAULTS = {
    :config_file => '/etc/landlord.conf'.freeze,
    :template_dir => '/etc/landlord'.freeze,
    :virtual_host_base_dir => '/web'.freeze,
    :virtual_host_config_dir => '/etc/httpd/vhosts.d'.freeze,
    :server_type => :apache,
    :virtual_host_subdirs => %w[ shared/log shared/config releases ]
  }.freeze

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  
  def initialize(config_file = nil)
    config = DEFAULTS
    
    if (config_file and File.exist?(config_file))
      config = DEFAULTS.merge(YAML.load(File.read(config_file)))
    end
    
    super(config)
    
    self.disabled_virtual_host_config_dir ||= File.expand_path(
      'disabled',
      self.virtual_host_config_dir
    )
  end
end
