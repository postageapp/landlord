require 'handlebar'
require 'fileutils'

class Landlord::VirtualHost
  # == Constants ============================================================

  # == Class Methods ========================================================

  # == Instance Methods =====================================================
  
  def initialize(server_name, options = nil)
    @options = {
      :server_name => server_name.freeze
    }
    
    if (options)
      @options.merge!(options)
    end
    
    @options[:virtual_host_path] ||= File.expand_path(
      @options[:server_name],
      Landlord.config.virtual_host_base_dir
    )
  end
  
  def server_name
    @options[:server_name]
  end
  
  def config_file_path(group = nil)
    File.expand_path(
      "#{@options[:server_name]}.conf",
      case (group)
      when :disabled
        Landlord.config.disabled_virtual_host_config_dir
      else
        Landlord.config.virtual_host_config_dir
      end
    )
  end
  
  def config_template_path(type = nil)
    Landlord.config.virtual_host_template or
      File.expand_path(
        [
          'virtual_host',
          type || Landlord.config.server_type,
          'conf'
        ].join('.'),
        Landlord.config.template_dir
      )
  end
  
  def config_file(type = nil)
    Handlebar::Template.new(
      File.read(self.config_template_path(type))
    ).render(
      :server_name => @options[:server_name],
      :virtual_host_path => @options[:virtual_host_path],
      :server_aliases => @options[:aliases] && @options[:aliases].join(' '),
      :server_redirects => @options[:redirects] && @options[:redirects].collect do |redirect|
        {
          :server_name => @options[:server_name],
          :redirect => redirect
        }
      end,
      :rack_env => @options[:rack_env],
      :rails_env => @options[:rails_env]
    ).sub(/\n+\Z/, "\n")
  end
  
  def enable!
    _config_file_path = self.config_file_path
    
    if (File.exist?(_config_file_path))
      # File already exists?!
    else
      File.rename(self.config_file_path(:disabled), _config_file_path)
    end
  end
  
  def disable!
    _config_file_path = self.config_file_path
    
    if (File.exist?(_config_file_path))
      File.rename(_config_file_path, self.config_file_path(:disabled))
    end
  end
  
  def add!
    File.open(self.config_file_path, 'w') do |f|
      f.write(self.config_file)
    end
    
    _virtual_host_path = @options[:virtual_host_path]
    
    Landlord.config.virtual_host_subdirs.each do |dir|
      _path = File.expand_path(
        dir,
        _virtual_host_path
      )
      
      unless (File.exist?(_path))  
        mkdir_p(_path)
      end
    end
  end
  
  def remove!
    _config_file_path = self.config_file_path

    if (File.exist?(_config_file_path))
      File.unlink(_config_file_path)
    end
  end
end
