class V1::Admin::CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :settings
  # has_many :users, embed :id
end
