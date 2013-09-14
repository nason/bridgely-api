class V1::Question < ActiveRecord::Base
  validates :question, :presence => true

  has_one :message
end
