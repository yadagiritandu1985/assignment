class CreateDoctorTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :doctor_time_slots do |t|
      t.references :doctor, foreign_key: true
      t.references :time_slot, foreign_key: true
      t.boolean :is_available, default: true

      t.timestamps
    end
  end
end
