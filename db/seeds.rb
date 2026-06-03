ReservationSeat.destroy_all
Reservation.destroy_all
Screening.destroy_all
Seat.destroy_all
Room.destroy_all
Movie.destroy_all
User.destroy_all

customer = User.create!(
  email: "customer@example.com",
  password_digest: "password",
  role: "customer"
)

matrix = Movie.create!(
  title: "The Matrix",
  description: "A hacker discovers that reality is not what it seems.",
  duration_minutes: 136
)
spirited_away = Movie.create!(
  title: "Spirited Away",
  description: "A young girl enters a mysterious spirit world.",
  duration_minutes: 125
)

room_1 = Room.create!(name: "Room 1")
room_2 = Room.create!(name: "Room 2")

[ room_1, room_2 ].each do |room|
  (1..3).each do |row_no|
    (1..5).each do |seat_no|
      Seat.create!(room: room, row_no: row_no, seat_no: seat_no)
    end
  end
end

matrix_screening = Screening.create!(
  movie: matrix,
  room: room_1,
  starts_at: 1.day.from_now.change(hour: 18, min: 0),
  price: 25
)

Screening.create!(
  movie: spirited_away,
  room: room_2,
  starts_at: 2.days.from_now.change(hour: 16, min: 30),
  price: 22
)

reservation = Reservation.create!(
  user: customer,
  screening: matrix_screening,
  status: "active"
)

room_1.seats.where(row_no: 1, seat_no: [ 1, 2 ]).each do |seat|
  ReservationSeat.create!(
    reservation: reservation,
    screening: matrix_screening,
    seat: seat
  )
end

Movie.create
