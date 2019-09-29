require './main'

run Rack::Cascade.new [Movies, Reservations]