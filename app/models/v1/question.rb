class V1::Question < ActiveRecord::Base
  validates :question, :presence => true

  #has_one :message

  # has_and_belongs_to_many :employees_messages
  # has_one :message, through: :company, table_name: :v1_employees_messages
end
