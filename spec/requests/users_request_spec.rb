require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe 'POST /api/v1/auth/register' do
    subject { post '/api/v1/auth/register', params: {name: 'user1', email: 'user1@gmail.com', password: 'password'}.to_json, headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' } }
    before { subject }

    it 'returns HTTP status 201' do
      expect(response).to have_http_status 201
    end

    it 'should create successfully' do
      body = JSON.parse(response.body)
      expect(body['message']).to eq("User created successfully")
    end
  end
  
  describe 'POST /api/v1/auth/login' do
    let!(:user) { FactoryBot.create(:user, email: 'user1@gmail.com', password: 'password') }
    subject { post '/api/v1/auth/login', params: {email: 'user1@gmail.com', password: 'password'}.to_json, headers: { 'Accept': 'application/json', 'Content-Type': 'application/json' } }
    before { subject }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'should create successfully' do
      body = JSON.parse(response.body)
      expect(body['message']).to eq("Login Successful!")
    end
  end

end
