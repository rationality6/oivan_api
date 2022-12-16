class V1::TestsController < ApplicationController
  def index
    query_result = Test.all

    render json: query_result,
           each_serializer: V1::TestSerializer,
           root: 'test_list'
  end

  def show
    test_with_questions = Test
                            .where(id: params[:id])
                            .includes(questions: [:options])
                            .first

    render json: test_with_questions,
           serializer: V1::TestWithQuestionSerializer,
           root: 'test_with_questions'
  end

  def create
    new_test = Test.new(
      user_id: current_user.id,
      name: params[:name],
      description: params[:description],
    )

    new_test.save
    render json: new_test,
           serializer: V1::TestSerializer,
           root: 'new_test'
  end

  def update
    test = Test.find(params[:id])
    test.update!(test_params_permit)

    test.save
    render json: test,
           serializer: V1::TestSerializer,
           root: 'test'
  end

  def destroy
    test = Test.find(params[:id])
    test.delete

    render status: :no_content
  end

  private

  def test_params_permit
    params.permit(
      :name,
      :description
    )
  end
end

