class V1::Admin::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin, :authorization_token
  has_one :company
end
