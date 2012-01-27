# encoding: utf-8

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "landlord"
  gem.homepage = "http://github.com/twg/landlord"
  gem.license = "MIT"
  gem.summary = %Q{Web server virtual-host tenant management tool}
  gem.description = %Q{A command-line tool for managing multiple virtual-host configurations on a web server}
  gem.email = "github@tadman.ca"
  gem.authors = ["Scott Tadman"]
  # dependencies defined in Gemfile
end

Jeweler::RubygemsDotOrgTasks.new
