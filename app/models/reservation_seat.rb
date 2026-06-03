class ReservationSeat < ApplicationRecord
  belongs_to :reservation
  belongs_to :screening
  belongs_to :seat

  validates :reservation_id, :screening_id, :seat_id, presence: true
end
