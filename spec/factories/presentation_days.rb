FactoryBot.define do
  factory :presentation_day do
    day_name { Date.today.strftime("%A") }
    date  { Date.today }
  end
end