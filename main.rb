require './deps'
require './db'

files = Dir["./app/models/*.rb"].sort + Dir["./app/api/*.rb"] + Dir["./app/transactions/*.rb"]
files.each do |file|
	require file
end