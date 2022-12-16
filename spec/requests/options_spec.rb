require 'rails_helper'

RSpec.describe 'Options', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }

  before {
    allow_any_instance_of(V1::OptionsController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(V1::OptionsController).to receive(:user_id).and_return(test_user.id)
  }

  it "create option" do

  end

  it "delete option" do

  end

end

