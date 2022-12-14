class V1::PingsController < ApplicationController

  def index
    render json: { "result": "alive" }
  end

  private

end

