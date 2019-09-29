class Movies < Grape::API
  prefix :api
  format :json
  
  get :movies do
    {movies: Movie.all}
  end
end