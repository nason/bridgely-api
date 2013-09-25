class V1::QuestionSerializer < ActiveModel::Serializer
  # attributes :id, :body, :direction, :company_id, :question_id, :employee_ids
  attributes :id, :title, :response_tag

end
