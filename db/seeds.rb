ReservationSeat.destroy_all
Reservation.destroy_all
Screening.destroy_all
Seat.destroy_all
Room.destroy_all

movies = Movie.order(:title).to_a

if movies.size < 3
  raise "Create at least 3 movies before running seeds."
end

rooms_data = [
  {
    name: "Room 1",
    rows: [7, 7, 7, 7],
  },
  {
    name: "Room 2",
    rows: [6, 6, 6, 3],
  },
]

rooms = rooms_data.map do |room_data|
  room = Room.create!(name: room_data[:name])

  room_data[:rows].each_with_index do |seats_count, row_index|
    row_no = row_index + 1

    (1..seats_count).each do |seat_no|
      Seat.create!(
        room: room,
        row_no: row_no,
        seat_no: seat_no,
      )
    end
  end

  room
end

screenings_data = [
  {
    movie_id: movies[0].id,
    room_id: rooms.first.id,
    day: 1.day.from_now,
    hour: 14,
    minute: 30,
    price: 22,
  },
  {
    movie_id: movies[0].id,
    room_id: rooms.second.id,
    day: 1.day.from_now,
    hour: 18,
    minute: 0,
    price: 25,
  },
  {
    movie_id: movies[1].id,
    room_id: rooms.first.id,
    day: 1.day.from_now,
    hour: 20,
    minute: 30,
    price: 28,
  },
  {
    movie_id: movies[1].id,
    room_id: rooms.second.id,
    day: 2.days.from_now,
    hour: 16,
    minute: 0,
    price: 22,
  },
  {
    movie_id: movies[2].id,
    room_id: rooms.first.id,
    day: 2.days.from_now,
    hour: 18,
    minute: 0,
    price: 28,
  },
  {
    movie_id: movies[2].id,
    room_id: rooms.second.id,
    day: 2.days.from_now,
    hour: 20,
    minute: 30,
    price: 28,
  },
  {
    movie_id: movies[2].id,
    room_id: rooms.first.id,
    day: 3.days.from_now,
    hour: 19,
    minute: 15,
    price: 30,
  },
]

screenings_data.each do |screening_data|
  Screening.create!(
    movie_id: screening_data[:movie_id],
    room_id: screening_data[:room_id],
    starts_at: screening_data[:day].change(
      hour: screening_data[:hour],
      min: screening_data[:minute],
    ),
    price: screening_data[:price],
  )
end

puts "Seeded #{Room.count} rooms, #{Seat.count} seats, and #{Screening.count} screenings."
puts "Users and movies were not changed."
