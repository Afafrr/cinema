class Seat < ApplicationRecord
  has_many :reservation_seats, dependent: :destroy

  belongs_to :room

  validates :row_no, :seat_no, presence: true
  validates :row_no, :seat_no, numericality: { only_integer: true, greater_than: 0 }
end
