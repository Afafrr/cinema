class Screening < ApplicationRecord
  has_many :reservations, dependent: :restrict_with_error
  has_many :reservation_seats, dependent: :restrict_with_error

  belongs_to :movie
  belongs_to :room

  validates :movie_id, :room_id, :starts_at, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :starts_at, uniqueness: { scope: :room_id }
end
