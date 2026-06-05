require "rails_helper"

RSpec.describe Reservation, type: :model do
  let(:movie) { Movie.create!(title: "Movie 1", duration_minutes: 120) }
  let(:room) { Room.create!(name: "Room 1") }
  let(:screening) { Screening.create!(movie: movie, room: room, starts_at: Time.current, price: 25) }
  let(:user) { User.create!(email: "user@example.com", password_digest: "password") }

  it "is invalid with a status outside the allowed list" do
    reservation = Reservation.new(user: user, screening: screening, status: "invalid_status")

    expect(reservation).not_to be_valid
  end
end
