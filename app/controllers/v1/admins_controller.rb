class V1::AdminsController < ApplicationController
  before_action :validation_create_user_params_present, only: [:create]

  def index
    raise 'no permission' unless has_permission?(user: current_user)

    query_result = User.all

    render json: query_result,
           each_serializer: V1::UserListSerializer,
           root: 'user_list'
  end

  # Teachers can assign Role (Teachers or Students) to Users.
  def create
    new_user = User.new(
      email: params[:email],
      password: params[:password],
      role: params[:role]
    )

    new_user.save

    render json: new_user
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

