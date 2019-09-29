require "dry/transaction"

class CreateMovie
  include Dry::Transaction
  include Dry::Monads

  step :persist

  def persist(attrs)
    movie = Movie.create(attrs.except(:presentation_days))
    
    attrs[:presentation_days].each do |presentation_day|
      date = presentation_day.to_date
      PresentationDay.create({
        date: date,
        movie_id: movie.id,
        day_name: date.strftime("%A")
      })
    end

    if movie.errors.blank?
      Success(movie: movie, presentation_days: movie.presentation_days)
    else
      Failure(errors: movie.errors)
    end
  end
end
