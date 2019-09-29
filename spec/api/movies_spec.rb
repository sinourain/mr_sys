require 'spec_helper'

describe Movies do 
  def app
    Movies
  end

  describe 'GET /api/movies' do 
    let(:movie) { create(:movie) }

    before do
      @today = Date.today

      3.times do |index|
        create(
          :presentation_day, 
          movie: movie, 
          day_name: (@today + index).strftime("%A"),
          date: (@today + index)
        )
      end
    end

    it 'gets an error if not include day_name in the params' do
      get '/api/movies'
      expect(last_response.status).to eq(400)
    end

    it 'gets a list of all movies by day' do 
      get '/api/movies', day_name: @today.strftime("%A")
      expect(last_response.status).to eq(200)
      movies = JSON.parse(last_response.body)['movies']
      expect(movies.count).to eq(1)
      expect(movies.first['name']).to eq(movie.name)
      expect(movies.first['description']).to eq(movie.description)
      expect(movies.first['image_url']).to eq(movie.image_url)
    end
  end
end