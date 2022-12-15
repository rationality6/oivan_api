class V1::QuestionsController < ApplicationController

  def create
    # new_test = Test.new(
    #   user_id: current_user.id,
    #   name: params[:name],
    #   description: params[:description],
    # )
    #
    # new_test.save
    # render json: new_test,
    #        serializer: V1::TestSerializer,
    #        root: 'new_test'
  end

  def destroy
    # test = Test.find(params[:id])
    # test.delete
    #
    # render status: :no_content
  end

  private

end

