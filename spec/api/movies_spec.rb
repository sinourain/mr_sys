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

  describe 'POST /api/movies' do
    before do
      expect(Movie.count).to eq(0)
    end

    it 'create a movie' do
      params = {
        name: "Example 2", 
        description: "Some description", 
        image_url: "s3.example.com/cinema/images/67890_movie.jpg",
        presentation_days: ["2019-12-12","2019-12-13","2019-12-14","2019-12-15"]
      }
      post '/api/movies', params
      
      expect(last_response.status).to eq(201)
      movies = Movie.all
      expect(movies.count).to eq(1)

      expect(movies.first.name).to eq(params[:name])
      expect(movies.first.description).to eq(params[:description])
      expect(movies.first.image_url).to eq(params[:image_url])
      expect(movies.first.presentation_days.count).to eq(4)

      presentation_days = JSON.parse(last_response.body)['presentation_days']
      expect(presentation_days.count).to eq(4)
    end

    it "shouldn't create a movie because not include params" do
      post '/api/movies'
      expect(last_response.status).to eq(400)
      expect(Movie.count).to eq(0)
    end
  end
end