require 'spec_helper'

describe Movies do 
  def app
    Movies
  end

  describe 'GET /api/movies' do 
    it 'gets a list of all movies' do 
      get '/api/movies'
      expect(last_response.status).to eq(200)
      expect(JSON.parse(last_response.body)['movies']).to eq([])
    end
  end
end