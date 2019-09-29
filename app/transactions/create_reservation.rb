require "dry/transaction"

class CreateReservation
  include Dry::Transaction
  include Dry::Monads

  step :persist

  def persist(attrs)
    reservation = Reservation.create(attrs)
  
    if reservation.errors.blank?
      Success(reservation: reservation)
    else
      Failure(errors: reservation.errors)
    end
  end
end
