class V1::Activity < ActiveRecord::Base
  belongs_to :employee
  belongs_to :message
  belongs_to :question
end
