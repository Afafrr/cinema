ReservationSeat.destroy_all
Reservation.destroy_all
Screening.destroy_all
Seat.destroy_all
Room.destroy_all
Movie.destroy_all
User.destroy_all

users_data = [
  {
    key: :customer,
    email: "customer@example.com",
    password: "password",
    role: "customer"
  },
  {
    key: :second_customer,
    email: "anna@example.com",
    password: "password",
    role: "customer"
  },
  {
    key: :employee,
    email: "employee@example.com",
    password: "password",
    role: "employee"
  }
]

movies_data = [
  {
    key: :matrix,
    title: "The Matrix",
    description: "A hacker discovers that reality is not what it seems.",
    duration_minutes: 136
  },
  {
    key: :spirited_away,
    title: "Spirited Away",
    description: "A young girl enters a mysterious spirit world.",
    duration_minutes: 125
  },
  {
    key: :dune,
    title: "Dune",
    description: "A noble family becomes part of a conflict over the desert planet Arrakis.",
    duration_minutes: 155
  }
]

rooms_data = [
  { key: :room_1, name: "Room 1" },
  { key: :room_2, name: "Room 2" },
  { key: :room_3, name: "Room 3" }
]

users = {}

users_data.each do |user_data|
  users[user_data[:key]] = User.create!(
    email: user_data[:email],
    password: user_data[:password],
    role: user_data[:role]
  )
end

movies = {}

movies_data.each do |movie_data|
  movies[movie_data[:key]] = Movie.create!(
    title: movie_data[:title],
    description: movie_data[:description],
    duration_minutes: movie_data[:duration_minutes]
  )
end

rooms = {}

rooms_data.each do |room_data|
  rooms[room_data[:key]] = Room.create!(name: room_data[:name])
end

rooms.values.each do |room|
  (1..4).each do |row_no|
    (1..6).each do |seat_no|
      Seat.create!(room: room, row_no: row_no, seat_no: seat_no)
    end
  end
end

screenings_data = [
  {
    key: :matrix_evening,
    movie: :matrix,
    room: :room_1,
    starts_at: 1.day.from_now.change(hour: 18, min: 0),
    price: 25
  },
  {
    key: :matrix_late,
    movie: :matrix,
    room: :room_1,
    starts_at: 2.days.from_now.change(hour: 20, min: 30),
    price: 25
  },
  {
    key: :matrix_late_2,
    movie: :matrix,
    room: :room_1,
    starts_at: 2.days.from_now.change(hour: 10, min: 30),
    price: 25
  },
  {
    key: :matrix_1_late_3,
    movie: :matrix,
    room: :room_1,
    starts_at: 2.days.from_now.change(hour: 15, min: 30),
    price: 25
  },
  {
    key: :matrix_2,
    movie: :matrix,
    room: :room_1,
    starts_at: 3.days.from_now.change(hour: 20, min: 30),
    price: 25
  },
  {
    key: :spirited_afternoon,
    movie: :spirited_away,
    room: :room_2,
    starts_at: 2.days.from_now.change(hour: 16, min: 30),
    price: 22
  },
  {
    key: :spirited_evening,
    movie: :spirited_away,
    room: :room_2,
    starts_at: 2.days.from_now.change(hour: 19, min: 0),
    price: 22
  },
  {
    key: :dune_evening,
    movie: :dune,
    room: :room_3,
    starts_at: 3.days.from_now.change(hour: 18, min: 15),
    price: 28
  },
  {
    key: :dune_late,
    movie: :dune,
    room: :room_1,
    starts_at: 3.days.from_now.change(hour: 21, min: 0),
    price: 28
  }
]

screenings = {}

screenings_data.each do |screening_data|
  screenings[screening_data[:key]] = Screening.create!(
    movie: movies[screening_data[:movie]],
    room: rooms[screening_data[:room]],
    starts_at: screening_data[:starts_at],
    price: screening_data[:price]
  )
end

reservations_data = [
  {
    user: :customer,
    screening: :matrix_evening,
    room: :room_1,
    row_no: 1,
    seat_numbers: [ 1, 2 ]
  },
  {
    user: :second_customer,
    screening: :matrix_evening,
    room: :room_1,
    row_no: 2,
    seat_numbers: [ 3, 4 ]
  },
  {
    user: :customer,
    screening: :matrix_late,
    room: :room_1,
    row_no: 3,
    seat_numbers: [ 1 ]
  },
  {
    user: :second_customer,
    screening: :spirited_afternoon,
    room: :room_2,
    row_no: 1,
    seat_numbers: [ 5, 6 ]
  },
  {
    user: :customer,
    screening: :spirited_evening,
    room: :room_2,
    row_no: 4,
    seat_numbers: [ 1, 2 ],
    status: "cancelled"
  },
  {
    user: :second_customer,
    screening: :dune_evening,
    room: :room_3,
    row_no: 2,
    seat_numbers: [ 2, 3, 4 ]
  },
  {
    user: :customer,
    screening: :dune_late,
    room: :room_1,
    row_no: 4,
    seat_numbers: [ 5 ]
  }
]

reservations_data.each do |reservation_data|
  reservation = Reservation.create!(
    user: users[reservation_data[:user]],
    screening: screenings[reservation_data[:screening]],
    status: reservation_data.fetch(:status, "active")
  )

  seats = rooms[reservation_data[:room]].seats.where(
    row_no: reservation_data[:row_no],
    seat_no: reservation_data[:seat_numbers]
  )

  seats.each do |seat|
    ReservationSeat.create!(
      reservation: reservation,
      screening: screenings[reservation_data[:screening]],
      seat: seat
    )
  end
end

puts "Seeded #{User.count} users, #{Movie.count} movies, #{Room.count} rooms, #{Seat.count} seats, #{Screening.count} screenings, #{Reservation.count} reservations."
