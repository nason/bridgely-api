class V1::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :message
  has_many :employees
end
