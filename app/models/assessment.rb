class Assessment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name
  field :last_name
  field :dob, type: Date
  field :surgeon
  field :date_of_surgery, type: Date
  field :state, default: 'new' 
  field :comment
  field :key_words, type: Array

  embeds_many :answers
  accepts_nested_attributes_for :answers

  before_create :init_data
  index key_words: 1

  scope :search, ->(text) {
    words = text.split /\W+/i
    regxs = words.compact.map do |word|
      /^#{word}.*/i
    end
    all(key_words: regxs)
  }

  # TODO: probably this can be more elegant
  # TODO: better if dates will come from client as normal Date objects.
  def init_data
    self.last_name = answers.select { |a| a.code == 'last-name' }.first.try :value
    self.first_name = answers.select { |a| a.code == 'first-name' }.first.try :value
    self.dob = answers.select { |a| a.code == 'dob' }.first.try :value
    self.surgeon = answers.select { |a| a.code == 'referring-surgeon' }.first.try :value
    self.date_of_surgery = answers.select { |a| a.code == 'procedure-date-patient-reported' }.first.try :value

    init_key_words
  end

  def init_key_words
    self.key_words = [last_name, first_name, surgeon]
    self.key_words += dob.to_s(:long).split(/[\s,]/).reject {|x| x.blank? } if dob
    self.key_words += date_of_surgery.to_s(:long).split(/[\s,]/).reject {|x| x.blank? } if date_of_surgery
  end

end
