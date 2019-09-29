class Reservations < Grape::API
  prefix :api
  format :json

  resource :reservations do
    desc 'Return all reservations between dates'
    params do
      requires :start_date, type: String, desc: 'Start date.'
      requires :end_date, type: String, desc: 'End date.'
    end
    get do
      start_date = params[:start_date].to_date
      end_date = params[:end_date].to_date
      reservations = Reservation.list_between_dates(start_date, end_date)
      { reservations: reservations }
    end
    
    desc 'Create a reservation'
    params do
      requires :movie_id, type: Integer, desc: 'Movie id.'
      requires :presentation_day_id, type: Integer, desc: 'Presentation day id.'
      requires :people_number, type: Integer, desc: 'People number.'
    end
    post do
      create_reservation = CreateReservation.new
      create_reservation.call(params) do |transaction|
        transaction.success do |reservation|
          { reservation: reservation }
        end

        transaction.failure do |errors|
          error!({ errors: errors }, 422)
        end
      end
    end
  end
end

