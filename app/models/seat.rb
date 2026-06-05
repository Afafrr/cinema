class Seat < ApplicationRecord
  has_many :reservation_seats, dependent: :destroy

  belongs_to :room

  validates :row_no, :seat_no, presence: true
  validates :row_no, :seat_no, numericality: { only_integer: true, greater_than: 0 }
  validates :seat_no, uniqueness: { scope: [ :room_id, :row_no ] } # seat num must be unique within the same row and room
end
