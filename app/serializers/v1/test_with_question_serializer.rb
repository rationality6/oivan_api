class V1::TestWithQuestionSerializer < ActiveModel::Serializer
  attributes :name, :description, :questions

  def questions
    questions_serial_option = { each_serializer: V1::QuestionSerializer, adapter: :attributes }
    questions_serials = ActiveModelSerializers::SerializableResource.new(object.questions, questions_serial_option)
    questions_serials
  end

end
