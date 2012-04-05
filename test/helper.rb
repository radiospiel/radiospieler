require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'ruby-debug'
require 'simplecov'
require 'test/unit'
SimpleCov.start do
  add_filter "test/*"
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'radiospieler'
require 'micro_sql'
App.env = "test"

App.logger.level = Logger::ERROR
MicroSql.logger = App.logger

class Test::Unit::TestCase
end
