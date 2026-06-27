require "rails_helper"

RSpec.describe Seat, type: :model do
  it "does not allow to create duplicate seat number in the same row and room" do
    room = Room.create!(name: "Seat Spec Room")

    Seat.create!(room: room, row_no: 1, seat_no: 1)
    seat2 = Seat.new(room: room, row_no: 1, seat_no: 1) # Builds an unsaved object; validation will check if it duplicates an existing seat.

    expect(seat2).not_to be_valid
  end
  it "same seat can be created in different rows or rooms" do
    room1 = Room.create!(name: "Seat Spec First Room")
    room2 = Room.create!(name: "Seat Spec Second Room")

    Seat.create!(room: room1, row_no: 1, seat_no: 1)
    duplicate = Seat.create!(room: room1, row_no: 2, seat_no: 1)
    seat2 = Seat.new(room: room2, row_no: 1, seat_no: 1)

    expect(duplicate).to be_valid
    expect(seat2).to be_valid
  end
end
