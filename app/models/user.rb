class User < ApplicationRecord 
  has_secure_password
  validates :email, presence: true, uniqueness: true 
  enum status: { active: 0, inactive: 1 } 
  before_validation :set_default_status, on: :create 
  private

  def set_default_status
    self.status ||= "active"  #  Set default status active 
  end

end
