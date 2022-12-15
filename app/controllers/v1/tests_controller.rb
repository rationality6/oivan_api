class V1::TestsController < ApplicationController
  def index
    query_result = User.all

    render json: query_result,
           each_serializer: V1::UserListSerializer,
           root: 'test_list'
  end

  private

end

