class V1::Admin::CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :settings, :users
  # removed :account_sid from above

  # has_many :users, embed :id
end
