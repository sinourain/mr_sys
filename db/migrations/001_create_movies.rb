Sequel.migration do
  change do
    create_table :movies do
      primary_key :id
      String :name
      String :description      
      String :image_url
      DateTime :created_at
      DateTime :updated_at
    end
  end
end