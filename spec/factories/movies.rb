FactoryBot.define do
  factory :movie do
    name { 'Example' }
    description  { 'Foo Bar Movie' }
    image_url { 's3.example.com/cinema/images/12345_movie.jpg' }
  end
end