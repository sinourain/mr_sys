Sequel.migration do
  change do
    create_table :reservations do
      primary_key :id
      Integer :movie_id
      Integer :presentation_day_id
      Integer :people_number
      DateTime :created_at
      DateTime :updated_at
    end
  end
end