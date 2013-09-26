# TODO: Investigate PG HSTORE and/or JSON field types for :data

class V1::Employee < ActiveRecord::Base

  # Validations
  validates :company_id, :presence => true
  validates :name, :presence => true
  validates :phone, :presence => true

  # Associations
  belongs_to :company, class_name: "V1::Admin::Company"

  has_many :activities
  has_many :messages, through: :activities
  has_many :questions, through: :activities

  # Serialization
  serialize :data, Hash

end
