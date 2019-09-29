Sequel.migration do
  change do
    create_table :presentation_days do
      primary_key :id
      Integer :movie_id
      String :day_name
      Date :date
      DateTime :created_at
      DateTime :updated_at
    end
  end
end