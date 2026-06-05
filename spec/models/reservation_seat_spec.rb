require "rails_helper"

RSpec.describe ReservationSeat, type: :model do
  let(:movie) { Movie.create!(title: "Movie 1", duration_minutes: 120) }
  let(:room) { Room.create!(name: "Room 1") }
  let(:screening) { Screening.create!(movie: movie, room: room, starts_at: Time.current, price: 25) }
  let(:seat) { Seat.create!(room: room, row_no: 1, seat_no: 1) }
  let(:user1) { User.create!(email: "user1@example.com", password_digest: "password") }
  let(:user2) { User.create!(email: "user2@example.com", password_digest: "password") }
  let(:reservation1) { Reservation.create!(user: user1, screening: screening) }

  it "it's not possible to reserve same seat twice on same screening" do
    ReservationSeat.create!(reservation: reservation1, screening: screening, seat: seat)
    reservation2 = Reservation.create!(user: user2, screening: screening)
    duplicate_reservation_seat = ReservationSeat.new(reservation: reservation2, screening: screening, seat: seat)

    expect(duplicate_reservation_seat).not_to be_valid
    expect(duplicate_reservation_seat.errors[:seat_id]).to include("has already been taken") # ensure that the validation error is on the seat_id field
  end

  it "allows the same seat to be reserved on a different screening" do
    other_screening = Screening.create!(movie: movie, room: room, starts_at: 1.day.from_now, price: 25)

    ReservationSeat.create!(reservation: reservation1, screening: screening, seat: seat)
    reservation_for_other_screening = Reservation.create!(user: user2, screening: other_screening)

    reservation_seat_for_other_screening = ReservationSeat.new(
      reservation: reservation_for_other_screening,
      screening: other_screening,
      seat: seat
    )

    expect(reservation_seat_for_other_screening).to be_valid
  end
end
