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
      post users_user_session_path, params: { sign_in: {
        email: "teacher@example.com", password: 12345
      } }

      json_parsed_response = JSON.parse(response.body)
      expect(json_parsed_response).to eq({"errors"=>"email or password is invalid"})
    end

  end
end
