class V1::AdminsController < ApplicationController
  before_action :validation_create_user_params_present

  def index
    query_result = User.all
    render json: query_result
    # render json: query_result, each_serializer: UserListSerializer, root: 'user_list'
  end

  # Teachers can assign Role (Teachers or Students) to Users.
  def create
    params[:email]
    params[:password]
    params[:role]
  end

  # Teachers can assign Role (Teachers or Students) to Users.
  def update

  end

  def delete

  end

  private

  def validation_create_user_params_present
    raise "no param role" unless params[:role].present?
    raise "no param email" unless params[:email].present?
    raise "no param password" unless params[:password].present?
  end

  def has_permission?(user:)
    user.is_teacher?
  end

end

