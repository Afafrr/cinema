require "rails_helper"

RSpec.describe Screening, type: :model do
  let(:movie) { Movie.create!(title: "Movie 1", duration_minutes: 120) }
  let(:room) { Room.create!(name: "Room 1") }
  let(:starts_at) { Time.current }

  it "does not allow to create duplicate screenings at the same time in the same room" do
    Screening.create!(movie: movie, room: room, starts_at: starts_at, price: 25)
    duplicate_screening = Screening.new(movie: movie, room: room, starts_at: starts_at, price: 25)

    expect(duplicate_screening).not_to be_valid
  end

  it "allows screenings at the same time in different rooms" do
    other_room = Room.create!(name: "Room 2")
    Screening.create!(movie: movie, room: room, starts_at: starts_at, price: 25)
    screening_in_different_room = Screening.new(movie: movie, room: other_room, starts_at: starts_at, price: 25)

    expect(screening_in_different_room).to be_valid
  end

  it "allows screenings at different times in the same room" do
    Screening.create!(movie: movie, room: room, starts_at: starts_at, price: 25)
    screening_at_different_time = Screening.new(movie: movie, room: room, starts_at: 1.hour.from_now, price: 25)

    expect(screening_at_different_time).to be_valid
  end
end
