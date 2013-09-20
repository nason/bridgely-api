class V1::Question < ActiveRecord::Base
  validates :question, :presence => true

  has_many :activities
  has_many :employees, through: :activities
  has_one :message, through: :activities
  has_one :company, through: :activities
end
