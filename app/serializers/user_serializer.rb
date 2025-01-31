class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_number, :status 
  has_many :tasks
end 
