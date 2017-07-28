class Todo < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: {maximum: 65535}, allow_nil: false

  scope :newest, -> {reorder updated_at: :desc, created_at: :desc}
end
