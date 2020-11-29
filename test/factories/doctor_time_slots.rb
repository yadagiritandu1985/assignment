FactoryBot.define do
  factory :doctor_time_slot do
    doctor
    time_slot
    is_available { true }   
  end
end
