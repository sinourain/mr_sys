class Movies < Grape::API
  prefix :api
  format :json
  
  get :example do
    {movies: []}
  end
end