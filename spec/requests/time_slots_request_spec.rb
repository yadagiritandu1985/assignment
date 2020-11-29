require 'rails_helper'

RSpec.describe "TimeSlots", type: :request do
  let!(:doctor) { FactoryBot.create(:doctor) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:time_slot1) { FactoryBot.create(:time_slot, date: Date.today, start_time: '10:00', end_time: '11:00', duration: 60) }
  let!(:time_slot2) { FactoryBot.create(:time_slot, date: Date.today, start_time: '11:00', end_time: '12:00', duration: 60) }
  let!(:doctor_time_slot1) { FactoryBot.create(:doctor_time_slot, time_slot_id: time_slot1.id, doctor_id: doctor.id) }
  let!(:doctor_time_slot2) { FactoryBot.create(:doctor_time_slot, time_slot_id: time_slot2.id, doctor_id: doctor.id) }

  describe 'GET /api/v1/time_slots/doctor_slots/:doctor_id' do
    subject { get "/api/v1/time_slots/doctor_slots/#{doctor.id}", headers: auth_headers(user) }
    before { subject }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'should list time_slots' do
      body = JSON.parse(response.body)
      expect(body['time_slots'].count).to eq(2)
    end
  end

  describe 'GET /api/v1/time_slots/available_slots/:doctor_id' do
    let!(:appointment) { FactoryBot.create(:appointment, user_id: user.id, doctor_id: doctor.id, doctor_time_slot_id: doctor_time_slot1.id) }

    subject { get "/api/v1/time_slots/available_slots/#{doctor.id}", headers: auth_headers(user) }
    before { subject }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'should list available_slots' do
      body = JSON.parse(response.body)7
      expect(body['time_slots'].count).to eq(1)
    end
  end

end
