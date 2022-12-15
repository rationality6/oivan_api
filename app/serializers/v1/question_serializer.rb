class V1::QuestionSerializer < ActiveModel::Serializer
  attributes :name, :description, :options

  def options
    options_serial_option = { each_serializer: V1::OptionSerializer, adapter: :attributes }
    options_serials = ActiveModelSerializers::SerializableResource.new(object.options, options_serial_option)
    options_serials
  end
end
