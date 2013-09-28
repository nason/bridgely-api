class V1::ActivitySerializer < ActiveModel::Serializer
  attributes :employee_id, :message_id, :question_id, :sms_status
  has_one :question
  has_one :message
end
