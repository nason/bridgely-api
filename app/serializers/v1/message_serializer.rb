class V1::MessageSerializer < ActiveModel::Serializer
  # attributes :id, :body, :direction, :company_id, :question_id, :employee_ids
  attributes :id, :body, :direction, :company_id
  has_one :question
  has_many :employees, embed: :ids
end
