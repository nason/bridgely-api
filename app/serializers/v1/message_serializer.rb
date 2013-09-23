class V1::MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :direction, :employee_ids
end
