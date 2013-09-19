class V1::Admin::CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :account_sid, :settings
  # has_many :users, embed :id
end
