FactoryBot.define do
    factory :user do
      name  "John Smith"
      email "john@smith.com"
      password "pass123"
      location_lat 51.503364
      location_lon -0.127625
      is_a_chef true
      
    end
  end
  