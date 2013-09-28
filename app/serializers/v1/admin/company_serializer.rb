class V1::Admin::CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :short_name, :settings

  # removed :account_sid from above
end
