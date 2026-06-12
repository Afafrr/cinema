require "rails_helper"

RSpec.describe "Reservations", type: :request do
  let(:movie) { Movie.create!(title: "Movie 1", duration_minutes: 120) }
  let(:room) { Room.create!(name: "Room 1") }
  let(:screening) { Screening.create!(movie: movie, room: room, starts_at: Time.current, price: 25) }
  let(:second_screening) { Screening.create!(movie: movie, room: room, starts_at: 1.day.from_now, price: 25) }
  let(:customer) { User.create!(email: "customer@example.com", password: "password123", role: "customer") }
  let(:seat) { Seat.create!(room: room, row_no: 1, seat_no: 1) }
  let(:second_seat) { Seat.create!(room: room, row_no: 1, seat_no: 2) }
  let(:reservation) { Reservation.create!(user: customer, screening: screening, status: "active") }
  let(:reservation_seat) { ReservationSeat.create!(reservation: reservation, screening: screening, seat: seat) }

  describe "POST /reservations" do
    it "unauthenticated - cannot reserve" do
      post reservations_url, params: { screening_id: screening.id, seat_ids: [ seat.id ] }

      expect(response).to redirect_to(new_user_session_path)
    end

    it "authenticated - can reserve" do
      sign_in customer
      post reservations_url, params: { screening_id: screening.id, seat_ids: [ seat.id, second_seat.id ] }

      expect(Reservation.count).to eq(1)
      expect(ReservationSeat.count).to eq(2)
    end

    it "No seats selected" do
      sign_in customer
      post reservations_url, params: { screening_id: screening.id, seat_ids: [] }

      expect(Reservation.count).to eq(0)
      expect(ReservationSeat.count).to eq(0)
      expect(response).to redirect_to(screening_path(screening))
    end
    it "same seat cannot be reserved twice" do
      sign_in customer
      post reservations_url, params: { screening_id: screening.id, seat_ids: [ seat.id, second_seat.id ] }
      post reservations_url, params: { screening_id: screening.id, seat_ids: [ seat.id ] }

      expect(Reservation.count).to eq(1)
      expect(ReservationSeat.count).to eq(2)
    end

    it "same seat can be reserved in other screening" do
      sign_in customer
      post reservations_url, params: { screening_id: screening.id, seat_ids: [ seat.id ] }
      post reservations_url, params: { screening_id: second_screening.id, seat_ids: [ seat.id ] }

      expect(Reservation.count).to eq(2)
      expect(ReservationSeat.count).to eq(2)
    end
  end
end
