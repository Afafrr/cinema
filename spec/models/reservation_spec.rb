require "rails_helper"

RSpec.describe Reservation, type: :model do
  let(:movie) { Movie.create!(title: "Movie 1", duration_minutes: 120) }
  let(:room) { Room.create!(name: "Reservation Spec Room") }
  let(:starts_at) { Time.current }
  let(:screening) do
    Screening.create!(
      movie: movie,
      room: room,
      starts_at: starts_at,
      ends_at: starts_at + movie.duration_minutes.minutes,
      price: 25
    )
  end
  let(:user) { User.create!(email: "user@example.com", password: "password") }

  it "is invalid with a status outside the allowed list" do
    reservation = Reservation.new(user: user, screening: screening, status: "invalid_status")

    expect(reservation).not_to be_valid
  end
end
