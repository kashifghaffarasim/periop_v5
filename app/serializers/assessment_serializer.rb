class AssessmentSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :dob, :surgeon, :date_of_surgery, :state, :comment, :created_at

  has_many :answers

  def id
    object.id.to_s
  end
end
