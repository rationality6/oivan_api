class V1::Tests::TestsController < ApplicationController
  def index
    render json: { "result": "tests" }
  end

  private

end

