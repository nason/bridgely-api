class V1::Admin::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin, :authorization_token
  has_one :company

  def include_admin?
    # Only include the admin property for admins
    self.admin
  end
end
