class Movies < Grape::API
  prefix :api
  format :json
  
  resource :movies do
    desc 'Return all movies by day name'
    params do
      requires :day_name, type: String, desc: 'Day name.'
    end
    get do
      { movies: Movie.list_by_day_name(params[:day_name]) }
    end
    
    desc 'Create a movie'
    params do
      requires :name, type: String, desc: 'Movie name.'
      requires :description, type: String, desc: 'Movie description.'
      requires :image_url, type: String, desc: 'Movie image URL.'
      requires :presentation_days, type: Array, desc: "Movie's presentation days."
    end
    post do
      create_movie = CreateMovie.new
      create_movie.call(params) do |transaction|
        transaction.success do |movie, presentation_days|
          { movie: movie, presentation_days: presentation_days }
        end

        transaction.failure do |errors|
          error!({ errors: errors }, 422)
        end
      end
    end
  end
end