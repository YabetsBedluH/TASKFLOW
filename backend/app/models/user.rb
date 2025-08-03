class User < ApplicationRecord
  has_secure_password
  #If a user is deleted, all their tasks will also be deleted from the DB.

  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
