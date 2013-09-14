class V1::Admin::CompanySerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :name, :settings
  has_many :users
end
