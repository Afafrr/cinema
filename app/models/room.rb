class Room < ApplicationRecord
  has_many :screenings, dependent: :restrict_with_error
  has_many :seats, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
