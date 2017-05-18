class Comment < ApplicationRecord
  belongs_to :room
  validates :user_id, :room_id, :text, presence: true
end
