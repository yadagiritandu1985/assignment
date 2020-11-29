require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:doctor)).to be_valid
  end
  
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :dept }
  end
end
