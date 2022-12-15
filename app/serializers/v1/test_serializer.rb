class V1::TestSerializer < ActiveModel::Serializer
  attributes :name, :description, :question_count

  def question_count
    object.questions.count
  end

end
