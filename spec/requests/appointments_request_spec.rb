require 'rails_helper'

RSpec.describe "Appointments", type: :request do
    let!(:doctor) { FactoryBot.create(:doctor) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:time_slot1) { FactoryBot.create(:time_slot, date: Date.today, start_time: '10:00', end_time: '11:00', duration: 60) }
    let!(:time_slot2) { FactoryBot.create(:time_slot, date: Date.today, start_time: '11:00', end_time: '12:00', duration: 60) }
    let!(:doctor_time_slot) { FactoryBot.create(:doctor_time_slot, time_slot_id: time_slot1.id, doctor_id: doctor.id) }

  describe 'POST /api/v1/appointments' do
    subject { post "/api/v1/appointments", params: {doctor_id: doctor.id, doctor_time_slot_id: doctor_time_slot.id}.to_json, headers: auth_headers(user) }
    before { subject }

    it 'returns HTTP status 201' do
      expect(response).to have_http_status 201
    end
  end 

  describe 'GET /api/v1/appointments' do
    let!(:appointment) { FactoryBot.create(:appointment, user_id: user.id, doctor_id: doctor.id, doctor_time_slot_id: doctor_time_slot.id) }

    subject { get "/api/v1/appointments", headers: auth_headers(user) }
    before { subject }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'should list appointments' do
      body = JSON.parse(response.body)
      expect(body['appointments'].count).to eq(1)
    end
  end

end
