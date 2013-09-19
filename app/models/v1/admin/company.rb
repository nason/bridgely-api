class V1::Admin::Company < ActiveRecord::Base

  # Validations
  validates :name, presence: true
  validates :name, uniqueness: true

  validates :account_sid, presence: true

  # Associations
  has_many :users
  has_many :employees
  has_many :messages, through: :employees

  # Serialize settings
  serialize :settings, Hash

end
