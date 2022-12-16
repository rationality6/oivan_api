require 'rails_helper'

RSpec.describe 'Options', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }

  before {
    allow_any_instance_of(V1::QuestionsController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(V1::QuestionsController).to receive(:user_id).and_return(test_user.id)
    allow_any_instance_of(V1::OptionsController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(V1::OptionsController).to receive(:user_id).and_return(test_user.id)
  }

  it "create option" do
    test = create(:test, :ruby_middle_test, user_id: test_user.id)
    question = create(:question, user_id: test_user.id, test_id: test.id)

    post options_path, params: { answer: true,
                                   description: '12',
                                   question_id: question.id }

    result = Option.where(answer: true, description: '12').present?
    expect(result).to eq(true)
  end

  it "delete option" do
    test = create(:test, :ruby_middle_test, user_id: test_user.id)
    question = create(:question, test_id: test.id, user_id: test_user.id)
    option = create(:option, question_id: question.id)
    delete "/api/v1/options/#{option.id}"

    result = Option.where(id: test.id).present?
    expect(result).to eq(false)
  end

end

