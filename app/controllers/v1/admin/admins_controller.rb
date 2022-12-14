class V1::Admin::AdminsController < ApplicationController
  def index
    render json: { "result": "admin" }
  end

  # Teachers can assign Role (Teachers or Students) to Users.
  def create

  end

  # Teachers can assign Role (Teachers or Students) to Users.
  def update

  end

  def delete

  end

  private

  def has_permission?(user:)
    user.is_teacher?
  end

end

