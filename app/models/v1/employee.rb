class V1::Employee < ActiveRecord::Base

  # Validations
  validates :company_id, :presence => true
  validates :name, :presence => true
  validates :phone, :presence => true, :uniqueness => true

  # Associations
  belongs_to :company
  has_many :messages, through: :company

end
