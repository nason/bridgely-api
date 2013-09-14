class V1::Message < ActiveRecord::Base

  validates :company_id, :presence => true
  validates :employee_id, :presence => true
  validates :body, :presence => true

  belongs_to :company
  belongs_to :employee

end
