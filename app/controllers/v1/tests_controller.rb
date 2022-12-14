class V1::TestsController < ApplicationController
  def index
    render json: { "result": "tests" }
  end

  private

end

