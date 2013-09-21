class V1::Question < ActiveRecord::Base
  validates :title, :presence => true
  # validates :message_id, :presence => true, :uniqueness => true

  has_many :activities
  has_many :employees, through: :activities

  has_one :message
  has_one :company, through: :message

  accepts_nested_attributes_for :message

end
