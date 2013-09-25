# TODO: Increase the size of the settings :settings
# TODO: Investigate PG HSTORE and/or JSON field types for :settings

class V1::Admin::Company < ActiveRecord::Base

  # Validations
  validates :name, presence: true
  validates :name, uniqueness: true

  # validates :account_sid, presence: true

  # Associations
  has_many :users
  has_many :employees
  has_many :messages
  has_many :questions, through: :messages

  # Serialize settings
  serialize :settings, Hash

  accepts_nested_attributes_for :users

end
