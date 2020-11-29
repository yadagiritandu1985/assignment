require 'rails_helper'

RSpec.describe TimeSlot, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:time_slot)).to be_valid
  end
  
  context 'validations' do
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :end_time }
    it { is_expected.to validate_presence_of :date }
  end
  
  context '#calculate_time_intervals(date, stime, etime' do
    subject { TimeSlot.calculate_time_intervals(Date.today, "10:00", "12:00", 60) }
    
    it 'should match' do
      expect(subject).to be_a_kind_of Array
    end
  end
end
