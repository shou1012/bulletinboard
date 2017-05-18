class Room < ApplicationRecord
  has_many :comments , dependent: :destroy
  # attr_accessor :id
end
