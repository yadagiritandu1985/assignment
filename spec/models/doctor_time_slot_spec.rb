require 'rails_helper'

RSpec.describe DoctorTimeSlot, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:doctor_time_slot)).to be_valid
  end


end
