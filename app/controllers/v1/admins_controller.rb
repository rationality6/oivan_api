class V1::AdminsController < ApplicationController
  before_action -> { has_permission?(user: current_user) }
  before_action :validation_create_user_params_present, only: [:create]

  def index
    query_result = User.all

    render json: query_result,
           each_serializer: V1::UserListSerializer,
           root: 'user_list'
  end

  def create
    raise "already exist" if User.find_by(email: params[:email]).present?

    new_user = User.new(
      email: params[:email],
      password: params[:password],
      role: params[:role]
    )

    new_user.save
    render json: new_user,
           serializer: V1::UserListSerializer,
           root: 'new_user'
  end

  # Teachers can assign Role (Teachers or Students) to Users.
  def update
    raise "no id present" unless params[:id].present?
    raise "user not exist" unless User.find(params[:id]).present?

    user = User.find(user_params_permit[:id])
    user.update!(user_params_permit)

    render json: user, serializer: V1::UserListSerializer, root: 'user'
  end

  def destroy
    user = User.find(params[:id])
    user.delete

    render status: :no_content
  end

  private

  def user_params_permit
    params.permit(
      :id,
      :email,
      :password,
      :role
    )
  end

  def validation_create_user_params_present
    raise "no param role" unless params[:role].present?
    raise "no param email" unless params[:email].present?
    raise "no param password" unless params[:password].present?
  end

  def has_permission?(user:)
    raise "no permission" unless user.is_teacher?
  end

end

