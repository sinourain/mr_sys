require 'spec_helper'

describe Reservations do 
  def app
    Reservations
  end
  
  let(:movie) { create(:movie) }

  before do
    @today = Date.today

    3.times do |index|
      presentation_day = create(
        :presentation_day, 
        movie: movie, 
        day_name: (@today + index).strftime("%A"),
        date: (@today + index)
      )

      create(
        :reservation,
        movie: movie,
        presentation_day: presentation_day,
        people_number: (2 + index)   
      )
    end
  end

  describe 'GET /api/reservations' do

    it 'gets an error if not include start_date or end_date in the params' do
      get '/api/reservations'
      expect(last_response.status).to eq(400)
    end

    it 'gets a list of all reservations between two dates' do 
      get '/api/reservations', start_date: @today + 1, end_date: @today + 1
      expect(last_response.status).to eq(200)
      reservations = JSON.parse(last_response.body)['reservations']
      expect(reservations.count).to eq(1)
      expect(reservations.first['movie_id'].to_i).to eq(movie.id)
    end

    it 'gets a list of all reservations between two long dates' do 
      get '/api/reservations', start_date: @today, end_date: @today + 300
      expect(last_response.status).to eq(200)
      reservations = JSON.parse(last_response.body)['reservations']
      expect(reservations.count).to eq(3)
      expect(reservations.first['movie_id'].to_i).to eq(movie.id)
      expect(reservations.last['movie_id'].to_i).to eq(movie.id)
    end
  end

  describe 'POST /api/reservations' do
    before do
      expect(Reservation.count).to eq(3)
    end

    it 'should create a reservation' do
      params = {
        movie_id: movie.id,
        presentation_day_id: Reservation.first.id,
        people_number: 5
      }
      post '/api/reservations', params
      
      expect(last_response.status).to eq(201)
      reservations = Reservation.all
      expect(reservations.count).to eq(4)

      expect(reservations.last.movie_id).to eq(params[:movie_id])
      expect(reservations.last.presentation_day_id).to eq(params[:presentation_day_id])
      expect(reservations.last.people_number).to eq(params[:people_number])
    end

    it "shouldn't create a reservation because not include params" do
      post '/api/reservations'
      expect(last_response.status).to eq(400)
      expect(Reservation.count).to eq(3)
    end

    it "shouldn't create a reservation because people_number is bigger than 10" do
      params = {
        movie_id: movie.id,
        presentation_day_id: Reservation.first.id,
        people_number: 11
      }

      post '/api/reservations', params
      expect(last_response.status).to eq(422)
      expect(Reservation.count).to eq(3)
    end

    it "shouldn't create a reservation because people_number is smaller than 1" do
      params = {
        movie_id: movie.id,
        presentation_day_id: Reservation.first.id,
        people_number: 0
      }

      post '/api/reservations', params
      expect(last_response.status).to eq(422)
      expect(Reservation.count).to eq(3)
    end
  end
end