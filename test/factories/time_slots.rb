FactoryBot.define do
  factory :time_slot do
    date { "29/11/2020" }
    start_time { "10:00" }  
    end_time { "12:00" }
    duration { 60 }  
  end
end
