$:.unshift File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'rspec'
require 'webmock/rspec'
require 'bundler/setup'

home = File.join(File.dirname(__FILE__), '/..')
ENV['BUNDLE_GEMFILE'] = "#{home}/Gemfile"
#WebMock.disable_net_connect!(:net_http_connect_on_start => false, :allow_localhost => true)


def webmock_asset(filename)
  File.expand_path(File.join(File.dirname(__FILE__), "assets", "webmock", filename))
end
