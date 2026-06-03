class Room < ApplicationRecord
  has_many :screenings, dependent: :restrict_with_error
  has_many :seats, dependent: :destroy
end
