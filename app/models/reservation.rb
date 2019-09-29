class Reservation < Sequel::Model

  #
  # Associations
  #
  many_to_one :movie
  many_to_one :presentation_day

  #
  # Validations
  #
  def validate
    super
    errors.add(:people_number, 'must be between 1 and 10') unless people_number >= 1 && people_number <= 10
  end

  dataset_module do
    def list_between_dates(start_date, end_date)
      where(presentation_day_id: PresentationDay.where(date: (start_date..end_date)).map(:id))
    end
  end

  #
  # Plugins
  #
  plugin :timestamps

end
