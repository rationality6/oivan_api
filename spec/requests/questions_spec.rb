require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }

  before {
    allow_any_instance_of(V1::QuestionsController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(V1::QuestionsController).to receive(:user_id).and_return(test_user.id)
  }

  it "create question" do
    test = create(:test, :ruby_middle_test, user_id: test_user.id)

    post questions_path, params: { name: 'simple arithmetic',
                                  description: '9 + 3',
                                  test_id: test.id}

    result = Question.where(name: 'simple arithmetic').present?
    expect(result).to eq(true)
  end

  it "delete question" do
    test = create(:test, :ruby_middle_test, user_id: test_user.id)
    question = create(:question, test_id: test.id, user_id: test_user.id)
    delete "/api/v1/questions/#{question.id}"

    result = Question.where(id: test.id).present?
    expect(result).to eq(false)
  end

end

