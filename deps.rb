ENV['RACK_ENV'] ||= 'development'

# load rubygems
require 'rubygems'

# load bundler
require 'bundler'

# load dotenv
require 'dotenv/load'

require 'pry'
require 'pry-remote'

%w(
	grape
	sequel
	sinatra
).each do |dep|
	require dep
end

$env = ENV['RACK_ENV']