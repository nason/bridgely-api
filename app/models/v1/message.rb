class V1::Message < ActiveRecord::Base

  # TODO: Default 'direction' to outbound, only set to inbound when received via Twilio's post

  validates :company_id, :presence => true
  validates :body, :presence => true

  belongs_to :company, class_name: "V1::Admin::Company"

  has_many :activities
  has_many :employees, through: :activities

  has_one :question

end
