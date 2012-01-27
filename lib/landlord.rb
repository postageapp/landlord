require 'yaml'

module Landlord
  # == Constants ============================================================

  VERSION = File.read(File.expand_path(File.join('..', 'VERSION'), File.dirname(__FILE__))).chomp.freeze

  DEFAULT_CONFIG_PATH = '/etc/landlord.conf'.freeze

  # == Submodules ===========================================================

  autoload(:Config, 'landlord/config')
  autoload(:VirtualHost, 'landlord/virtual_host')

  # == Module Methods =======================================================
  
  def self.config_path=(path)
    @config_path = path
  end

  def self.config_path
    @config_path || DEFAULT_CONFIG_PATH
  end
  
  def self.config
    @config ||= Config.new(self.config_path)
  end
end
