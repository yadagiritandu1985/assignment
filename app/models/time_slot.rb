class TimeSlot < ApplicationRecord
  has_many :doctor_time_slots
  has_many :doctors, through: :doctor_time_slots

  validates :start_time, :date, :end_time, presence: true
  
  
  # calculate time slots based on interval
  # date should be in this format (DD/MM/YYYY) ex: '30/11/2020'
  # stime, etime should be as strings ex: '10:00', '14:00'
  # interval value should be in minutes ex: 30 (default=30)
  def self.calculate_time_intervals(date, stime, etime, interval=30)
    stime = stime.to_time
    etime = etime.to_time
    diff = etime.to_time - stime.to_time         # diff in seconds
    diff_in_mins = diff/60                       # diff in mins
    count = (diff_in_mins/interval).to_i
    intervals = []
    count.times do |a|
      elem = (stime + ((a + 1) * interval.minutes))
      if a == 0
        starts_at = stime
        ends_at = elem
      else
        starts_at = (stime + ((a) * interval.minutes))
        ends_at = elem
      end
      intervals << {date: date.to_date, start_time: starts_at.strftime('%I:%M %p'), end_time: ends_at.strftime('%I:%M %p'), duration: interval}
    end
    intervals
  end

end
