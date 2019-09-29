require 'spec_helper'

describe Movies do 
  def app
    Movies
  end

  describe 'GET /api/example' do 
    it 'gets a list of all movies' do 
      get '/api/example'
      expect(last_response.status).to eq(200)
    end
  end
end