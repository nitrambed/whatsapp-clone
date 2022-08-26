class User < ApplicationRecord
  has_secure_password

  validates :phone_number, uniqueness: true

  has_many :contacts, dependent: :destroy
  has_many :user_contacts, through: :contacts

  has_many :conversations
  has_many :messages
end
