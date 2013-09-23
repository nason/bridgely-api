class V1::MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :direction, :company_id, :question_id, :employee_ids
end
