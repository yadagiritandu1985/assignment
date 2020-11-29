class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  belongs_to :doctor_time_slot
  
  validates :user_id, uniqueness: { scope: [:doctor_id, :doctor_time_slot_id] }
  
  after_create :mark_doctor_time_slot
  after_destroy :restore_doctor_time_slot
  
  def mark_doctor_time_slot
    doctor_time_slot.update(is_available: false)
  end
  
  def restore_doctor_time_slot
    doctor_time_slot.update(is_available: true)
  end
end
