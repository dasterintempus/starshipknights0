STARSHIPKNIGHTS_ROOT = File.dirname(File.expand_path(__FILE__))

require 'rubygems' unless RUBY_VERSION =~ /1\.9/
require 'gosu'
require 'zlib'
require 'pp'
require 'json'

Dir["#{STARSHIPKNIGHTS_ROOT}/**/*.rb"].each do |file|
  $LOAD_PATH.unshift(File.dirname(file))
end

Dir["#{STARSHIPKNIGHTS_ROOT}/**/*.rb"].each do |file|
  require File.basename(file)
end

module StarshipKnights
  VERSION = "0.0.5a"
end
