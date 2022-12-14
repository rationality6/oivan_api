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

    # it 'user promote to platinum' do
    #   expect(test_user.profile.tier).to eq('standard')
    #   post purchase_purchase_transactions_url, params: { spend: 10_000, test_user_id: test_user.id }
    #   expect(User.find(test_user.id).profile.tier).to eq('gold')
    #   post purchase_purchase_transactions_url, params: { spend: 50_000, test_user_id: test_user.id }
    #   expect(User.find(test_user.id).profile.tier).to eq('platinum')
    # end
    #
    # it 'when user got promoted to gold got airport reward' do
    #   expect(test_user.profile.tier).to eq('standard')
    #   post purchase_purchase_transactions_url, params: { spend: 10_000, test_user_id: test_user.id }
    #   the_user = User.find(test_user.id)
    #   expect(the_user.profile.tier).to eq('gold')
    #   reward_present = Reward.where({ user_id: the_user, reward_name: '4x Airport Lounge Access Reward' }).present?
    #   expect(reward_present).to eq(true)
    # end
  end
end
