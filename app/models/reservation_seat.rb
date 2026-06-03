class ReservationSeat < ApplicationRecord
  belongs_to :reservation
  belongs_to :screening
  belongs_to :seat
end
