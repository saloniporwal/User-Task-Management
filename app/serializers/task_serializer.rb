class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :due_date, :user_id
  belongs_to :user
end
