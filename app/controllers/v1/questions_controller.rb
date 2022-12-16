class V1::QuestionsController < ApplicationController

  def create
    new_question = Question.new(question_params_permit)
    new_question.user_id = current_user.id

    new_question.save
    render json: new_question,
           serializer: V1::QuestionSerializer,
           root: 'new_question'
  end

  def destroy
    question = Question.find(params[:id])
    question.delete

    render status: :no_content
  end

  private

  def question_params_permit
    params.permit(
      :test_id,
      :name,
      :description
    )
  end

end

