class CreateTimeSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :time_slots do |t|
      t.date :date
      t.string :start_time
      t.string :end_time
      t.string :duration

      t.timestamps
    end
  end
end
