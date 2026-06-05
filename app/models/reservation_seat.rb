class ReservationSeat < ApplicationRecord
  belongs_to :reservation
  belongs_to :screening
  belongs_to :seat

  validates :reservation_id, :screening_id, :seat_id, presence: true
  validates :seat_id, uniqueness: { scope: :screening_id } # a seat can only be reserved once for a given screening
end
