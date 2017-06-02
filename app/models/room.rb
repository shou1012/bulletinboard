class Room < ApplicationRecord
  has_many :comments , dependent: :destroy
  validates :name, presence: true
  validates :user_id, presence: true
  # attr_accessor :id
end
