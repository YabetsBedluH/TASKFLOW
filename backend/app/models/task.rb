class Task < ApplicationRecord
  belongs_to :user

  STATUSES = ['todo', 'doing', 'done']

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
end
