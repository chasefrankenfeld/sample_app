class Micropost < ApplicationRecord
  # Relationships
  belongs_to(:user)
  has_many(:comments, dependent: :destroy)

  # Validations
  default_scope -> { order(updated_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

end
