require './deps'
require './db'

(Dir["./app/models/*.rb"].sort + Dir["./app/api/*.rb"]).each do |file|
	require file
end