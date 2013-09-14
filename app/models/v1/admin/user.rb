class V1::Admin::User < ActiveRecord::Base

  #Validations
  validates :email, :presence => true
  validates :email, :uniqueness => true
  validates :name, :presence => true
  validates :encrypted_password, :presence => true

  #Associations
  belongs_to :company

end
