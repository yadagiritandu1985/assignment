FactoryBot.define do
  factory :appointment do
    user
    doctor
    doctor_time_slot
    status { nil }   
  end
end
