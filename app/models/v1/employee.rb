# TODO: Change :data to Text column type
# TODO: Increase the size of :data column
# TODO: Investigate PG HSTORE and/or JSON field types for :data

class V1::Employee < ActiveRecord::Base

  # Validations
  validates :company_id, :presence => true
  validates :name, :presence => true
  validates :phone, :presence => true, :uniqueness => true

  # Associations
  belongs_to :company, class_name: "V1::Admin::Company"

  has_and_belongs_to_many :messages
  has_and_belongs_to_many :questions, join_table: :v1_employees_messages

  # Serialization
  serialize :data, Hash

end
