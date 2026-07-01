require "rails_helper"

RSpec.describe Screening, type: :model do
  let(:movie) { Movie.create!(title: "Movie 1", duration_minutes: 120) }
  let(:room) { Room.create!(name: "Screening Spec Room") }
  let(:starts_at) { Time.current }
  let(:ends_at) { starts_at + movie.duration_minutes.minutes }

  it "does not allow to create duplicate screenings at the same time in the same room" do
    Screening.create!(movie: movie, room: room, starts_at: starts_at, ends_at: ends_at, price: 25)
    duplicate_screening = Screening.new(movie: movie, room: room, starts_at: starts_at, ends_at: ends_at, price: 25)

    expect(duplicate_screening).not_to be_valid
  end

  it "allows screenings at the same time in different rooms" do
    other_room = Room.create!(name: "Other Screening Spec Room")
    Screening.create!(movie: movie, room: room, starts_at: starts_at, ends_at: ends_at, price: 25)
    screening_in_different_room = Screening.new(movie: movie, room: other_room, starts_at: starts_at, ends_at: ends_at, price: 25)

    expect(screening_in_different_room).to be_valid
  end

  it "allows screenings at non-overlapping times in the same room" do
    later_starts_at = starts_at + 3.hours

    Screening.create!(movie: movie, room: room, starts_at: starts_at, ends_at: ends_at, price: 25)
    screening_at_different_time = Screening.new(
      movie: movie,
      room: room,
      starts_at: later_starts_at,
      ends_at: later_starts_at + movie.duration_minutes.minutes,
      price: 25,
    )

    expect(screening_at_different_time).to be_valid
  end

  it "does not allows screenings at overlapping times in the same room" do
    later_starts_at = starts_at + 1.hour + 30.minutes

    Screening.create!(movie: movie, room: room, starts_at: starts_at, ends_at: ends_at, price: 25)
    screening_at_overlapping_time = Screening.new(
      movie: movie,
      room: room,
      starts_at: later_starts_at,
      ends_at: later_starts_at + movie.duration_minutes.minutes,
      price: 25,
    )

    expect(screening_at_overlapping_time).not_to be_valid
  end
end
