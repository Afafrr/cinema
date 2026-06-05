require "rails_helper"

RSpec.describe Room, type: :model do
  it "room name should be present and unique" do
    Room.create!(name: "Room 1")
    duplicate = Room.new(name: "Room 1")

    expect(duplicate).not_to be_valid
  end
end
