require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }
  let!(:test_student) { create(:user, :skip_validate, :student) }

  before {
    allow_any_instance_of(V1::AdminsController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(V1::AdminsController).to receive(:user_id).and_return(test_user.id)
  }

  describe 'crud' do
    it 'user list' do
      get admins_path, params: {}

      json_parsed_response = JSON.parse(response.body)

      expacted_result = [
        { "email" => "teacher@gmail.com", "role" => "teacher" },
        { "email" => "student@gmail.com", "role" => "student" }
      ]

      expect(json_parsed_response).to eq(expacted_result)
    end

    it 'created new user' do
      email = "foobar@gmail.com"

      result = User.where(email: email).present?
      expect(result.present?).to eq(false)

      post admins_path, params: { email: email, password: 'superpass', role: "teacher" }

      result = User.where(email: email).present?
      expect(result.present?).to eq(true)
    end

    it 'already exist email' do
      email = "test0@gmail.com"
      post admins_path, params: { email: email, password: 'superpass', role: "teacher" }

      expect {
        post admins_path, params: { email: email, password: 'superpass', role: "teacher" }
      }.to raise_error("already exist")
    end

    pending "update"
    pending "delete"

  end
end

