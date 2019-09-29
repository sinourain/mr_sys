require "dry/transaction"

class CreateReservation
  include Dry::Transaction
  include Dry::Monads

  step :persist

  def persist(attrs)
    reservation = Reservation.new(attrs)
    if reservation.valid?
      reservation.save
      Success(reservation: reservation)
    else
      Failure(errors: reservation.errors)
    end
  end
end
