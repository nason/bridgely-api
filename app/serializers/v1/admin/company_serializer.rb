class V1::Admin::CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :settings

  # removed :account_sid from above
end
