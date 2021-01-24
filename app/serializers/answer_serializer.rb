class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :code, :type, :text, :desc, :group, :value, :variants

  def id
    object.id.to_s
  end
end
