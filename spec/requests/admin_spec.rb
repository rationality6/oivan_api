require 'rails_helper'

RSpec.describe 'Admin', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }
  let!(:test_student) { create(:user, :skip_validate, :student) }

  describe 'login' do
    it 'success got token_value' do

    end

  end
end
