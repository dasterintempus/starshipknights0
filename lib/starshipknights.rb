STARSHIPKNIGHTS_ROOT = File.dirname(File.expand_path(__FILE__))

require 'rubygems' unless RUBY_VERSION =~ /1\.9/
require 'gosu'
#require 'require_all'
require 'zlib'
require 'pp'
require 'json'

#def require_dir(dir)
#  Dir["#{dir}/*.rb"].each do |file| 
#    require File.basename(file, File.extname(file))
#  end
#end

Dir["#{STARSHIPKNIGHTS_ROOT}/**/*.rb"].each do |file|
  $LOAD_PATH.unshift(File.dirname(file))
end

Dir["#{STARSHIPKNIGHTS_ROOT}/**/*.rb"].each do |file|
  require File.basename(file)
end

#require_dir "./util"
#require_dir "./entities"
#require_dir "./ais"
#require_dir "./battle"
#require_dir "./game"
#require_dir "./application"

module StarshipKnights
  VERSION = "0.0.4"
end
