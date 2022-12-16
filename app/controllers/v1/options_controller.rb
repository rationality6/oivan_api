class V1::OptionsController < ApplicationController

  def create
    new_option = Option.new(options_params_permit)
    new_option.user_id = current_user.id

    new_option.save
    render json: new_option,
           serializer: V1::OptionSerializer,
           root: 'new_option'
  end

  def destroy
    option = Option.find(params[:option_id])
    option.delete

    render status: :no_content
  end

  private

  def options_params_permit
    params.permit(
      :question_id,
      :description,
      :answer
    )
  end

end

