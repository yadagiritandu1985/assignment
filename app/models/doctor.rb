class Doctor < ApplicationRecord
  has_many :doctor_time_slots
  has_many :time_slots, through: :doctor_time_slots

  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates_presence_of :name, :dept
end
