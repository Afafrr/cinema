require "rails_helper"

RSpec.describe Room, type: :model do
  it "room name should be present and unique" do
    room_name = "Room Spec Unique Room"

    Room.create!(name: room_name)
    duplicate = Room.new(name: room_name)

    expect(duplicate).not_to be_valid
  end
end
