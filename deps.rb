ENV['RACK_ENV'] ||= 'development'

# load rubygems
require 'rubygems'

# load bundler
require 'bundler'

%w(
	grape
	sequel
	sinatra
).each do |dep|
	require dep
end

$env = ENV['RACK_ENV']