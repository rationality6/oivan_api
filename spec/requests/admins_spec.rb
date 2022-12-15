require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }
  let!(:test_student) { create(:user, :skip_validate, :student) }

  describe 'CRUD' do

    before {
      allow_any_instance_of(V1::AdminsController).to receive(:authenticate_request!).and_return(true)
      allow_any_instance_of(V1::AdminsController).to receive(:user_id).and_return(test_user.id)
    }

    it 'user list' do
      get admins_path, params: {}

      json_parsed_response = JSON.parse(response.body)

      expacted_result = [
        { "email" => "teacher@gmail.com", "role" => "teacher" },
        { "email" => "student@gmail.com", "role" => "student" }
      ]

      expect(json_parsed_response).to eq(expacted_result)
    end

    context "create" do
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
    end

    it "update" do
      expect(test_user.email == 'teacher@gmail.com').to eq(true)
      patch "/api/v1/admins/#{ test_user.id }", params: {
        email: 'updated_teacher@gmail.com'
      }

      json_parsed_response = JSON.parse(response.body)

      expect(json_parsed_response).to eq({"email"=>"updated_teacher@gmail.com", "role"=>"teacher"})

    end

    it "delete" do
      delete "/api/v1/admins/#{ test_student.id }"

      result = User.where(id: test_student.id).present?
      expect(result).to eq(false)
    end

  end

  describe 'student no permission' do
    before {
      allow_any_instance_of(V1::AdminsController).to receive(:authenticate_request!).and_return(true)
      allow_any_instance_of(V1::AdminsController).to receive(:user_id).and_return(test_student.id)
    }
    it 'user list' do
      expect {
        get admins_path, params: {}
      }.to raise_error("no permission")
    end

    it 'created new user' do
      email = "foobar@gmail.com"

      expect {
        post admins_path, params: { email: email, password: 'superpass', role: "teacher" }
      }.to raise_error("no permission")
    end

    it "update" do
      expect {
        patch "/api/v1/admins/#{ test_user.id }", params: {
          email: 'updated_teacher@gmail.com'
        }
      }.to raise_error("no permission")
    end

    it "delete" do
      expect {
        delete "/api/v1/admins/#{ test_student.id }"
      }.to raise_error("no permission")
    end

  end
end

