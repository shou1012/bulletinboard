class Comment < ApplicationRecord
  belongs_to :room
  validates :user_id, :text, presence: true
end
