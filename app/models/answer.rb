class Answer
  include Mongoid::Document

  field :type
  field :code
  field :text
  field :desc
  field :group
  field :variants, type: Array
  field :value

  embedded_in :assessment
end
