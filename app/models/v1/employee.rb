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
  has_many :messages, class_name: "V1::Message", through: :company
#  has_many :questions, class_name: "V1::Question", through: :messages

  serialize :data, Hash

end
