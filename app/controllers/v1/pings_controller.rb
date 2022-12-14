class V1::PingsController < ApplicationController
  skip_before_action :authenticate_request!

  def index
    render json: { "result": "alive" }
  end

  private

end

