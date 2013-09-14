class V1::Admin::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :company_id, :admin
end
