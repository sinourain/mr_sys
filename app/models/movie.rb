class Movie < Sequel::Model

  #
  # Associations
  #
  one_to_many :presentation_days

  dataset_module do
    def list_by_day_name(day_name)
      where(id: PresentationDay.where(day_name: day_name).map(:movie_id))
    end
  end

  #
  # Plugins
  #
  plugin :timestamps
  
end
