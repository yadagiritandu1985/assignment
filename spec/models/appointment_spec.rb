require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:appointment)).to be_valid
  end
end
