require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }

  before {
    allow_any_instance_of(V1::QuestionsController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(V1::QuestionsController).to receive(:user_id).and_return(test_user.id)
  }

  it "create question" do
    post question_path, params: { name: 'Ruby on rails middle test',
                               description: 'middle test',
                               user_id: test_user.id }

    result = Test.where(name: 'Ruby on rails middle test').present?
    expect(result).to eq(true)
  end

  it "delete question" do

  end

end

