class Contact < ApplicationRecord
  validates_uniqueness_of :user_contact_id, scope: [:user_id]
  belongs_to :user
  belongs_to :user_contact
end
