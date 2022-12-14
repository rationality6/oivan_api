require 'rails_helper'

RSpec.describe 'Tests', type: :request do
  let!(:test_user) { create(:user, :skip_validate, :teacher) }

  before {
    allow_any_instance_of(V1::TestsController).to receive(:authenticate_request!).and_return(true)
    allow_any_instance_of(V1::TestsController).to receive(:user_id).and_return(test_user.id)
  }

  it 'get list of test' do
    tests = FactoryBot.create_list(:test, 5, user_id: test_user.id)

    get tests_path
    json_parsed_response = JSON.parse(response.body)

    expect(json_parsed_response.length).to be(tests.length)
  end

  it 'create new test' do
    post tests_path, params: { name: 'Ruby on rails middle test',
                               description: 'middle test',
                               user_id: test_user.id }

    result = Test.where(name: 'Ruby on rails middle test').present?
    expect(result).to eq(true)
  end

  it 'update test' do
    test = create(:test, :ruby_middle_test, user_id: test_user.id)
    patch "/api/v1/tests/#{test.id}", params: { name: 'Ruby on rails final test',
                                                description: 'final test' }

    expect(Test.find(test.id).name).to eq('Ruby on rails final test')
  end

  it 'delete test' do
    test = create(:test, :ruby_middle_test, user_id: test_user.id)
    delete "/api/v1/tests/#{test.id}"

    result = Test.where(id: test.id).present?
    expect(result).to eq(false)
  end

  it 'get test with related questions and options' do
    test = create(:test, :ruby_middle_test, user_id: test_user.id)
    questions = FactoryBot.create_list(:question, 5, user_id: test_user.id, test_id: test.id)
    FactoryBot.create_list(:option, 5, user_id: test_user.id, question_id: questions.first.id)

    get test_path(test.id)

    json_parsed_response = JSON.parse(response.body)

    serial_option = { each_serializer: V1::TestWithQuestionSerializer, adapter: :attributes }
    serials = ActiveModelSerializers::SerializableResource.new(test, serial_option)
    result = JSON.parse(serials.to_json)

    expect(json_parsed_response).to eq(result)
  end

end
