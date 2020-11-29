# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doctor.create([
               { name: 'Doctor1', dept: 'Dept1' }, 
               { name: 'Doctor2', dept: 'Dept2' }, 
               { name: 'Doctor3', dept: 'Dept3' },
               { name: 'Doctor4', dept: 'Dept4' },
               { name: 'Doctor5', dept: 'Dept5' }
              ])

(0...2).each do |i|    
  morning_slots = TimeSlot.calculate_time_intervals((Date.today + i.day), "10:00", "13:00", 60)
  TimeSlot.create(morning_slots)
  
  evng_slots = TimeSlot.calculate_time_intervals((Date.today + i.day), "17:00", "19:00", 60)
  TimeSlot.create(evng_slots)
end

(0...2).each do |i|
  date_wise_slots = TimeSlot.where(date: (Date.today - i.day))
  Doctor.all.each_with_index do |doc, i|
    if i < 3
      date_wise_slots.first(4).each {|a| doc.doctor_time_slots.create(time_slot_id: a.id) }
    else
      date_wise_slots.last(4).each {|a| doc.doctor_time_slots.create(time_slot_id: a.id) }
    end
  end
end
