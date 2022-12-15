require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:test_user) { create(:user, :skip_validate) }
  let!(:user_teacher) { create(:user, :skip_validate, :teacher) }
  let!(:user_student) { create(:user, :skip_validate, :student) }

  describe 'unit test' do

    it "default after_initialize user role value student?"do
      expect(test_user.role).to eq("student")
    end

    it 'when user_teacher is_teacher?' do
      expect(user_teacher.is_teacher?).to eq(true)
    end

    it 'when user_student is_teacher?' do
      expect(user_student.is_teacher?).to eq(false)
    end

    it 'when user_teacher user is_student?' do
      expect(user_teacher.is_student?).to eq(false)
    end

    it 'when user_student is_student?' do
      expect(user_student.is_student?).to eq(true)
    end

    it "on_jwt_dispatch" do
      payload = {
        "sub"=>"2",
        "scp"=>"users",
        "aud"=>nil,
        "iat"=>1671035017,
        "exp"=>1671038617,
        "jti"=>"689351bd-ae4e-4448-8805-117216e010bc"}

      User.new.on_jwt_dispatch(payload)

      result = JwtDenylist.where(jti: "689351bd-ae4e-4448-8805-117216e010bc").present?
      expect(result).to eq(true)
    end

  end
end
