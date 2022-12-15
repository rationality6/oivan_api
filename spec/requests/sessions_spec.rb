require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:test_user) { create(:user, :default_teacher, :default_password) }

  describe 'login' do
    it 'success got token_value' do
      post users_user_session_path, params: { sign_in: {
        email: "teacher@example.com", password: 12345678
      } }

      json_parsed_response = JSON.parse(response.body)
      expect(json_parsed_response["token_value"].present?).to eq(true)
    end

    it 'with wrong password' do
      expect {
        post users_user_session_path, params: { sign_in: {
          email: 'teacher@example.com',
          password: 12345
        } }
      }.to raise_error('email or password is invalid')
    end

  end

  describe 'validation params' do
    it 'no param sign_in' do
      expect {
        post users_user_session_path, params: {}
      }.to raise_error('no param sign_in')
    end

    it 'no param sign_in email' do
      expect {
        post users_user_session_path, params: { sign_in: {
          password: 12345
        } }
      }.to raise_error('no param sign_in email')
    end

    it 'no param sign_in password' do
      expect {
        post users_user_session_path, params: { sign_in: {
          email: 'teacher@example.com'
        } }
      }.to raise_error('no param sign_in password')
    end

  end
end
