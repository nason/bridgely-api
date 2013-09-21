class V1::Question < ActiveRecord::Base
  validates :question, :presence => true

  has_many :activities
  has_many :employees, through: :activities
  has_many :messages, through: :activities
  has_one :company, through: :activity

end
