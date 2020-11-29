class DoctorTimeSlot < ApplicationRecord
  belongs_to :doctor
  belongs_to :time_slot
end
