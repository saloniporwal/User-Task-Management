class Task < ApplicationRecord
  belongs_to :user 
  enum status: { pending: 0, in_progress: 1, completed: 2 }
  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :due_date, presence: true 
  validate :valid_due_date

  private

  def valid_due_date
    if due_date.present? && due_date < Time.current
      errors.add(:due_date, "must be valid date ")
    end
  end
end
