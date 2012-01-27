require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'landlord'

class Test::Unit::TestCase
  def expected_result(name)
    File.read(
      File.expand_path(
        File.join('expected_results', name),
        File.dirname(__FILE__)
      )
    )
  end
end
