class V1::EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :company_id, :data
end
