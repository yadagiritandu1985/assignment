class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :doctor, foreign_key: true
      t.references :user, foreign_key: true
      t.references :doctor_time_slot, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
