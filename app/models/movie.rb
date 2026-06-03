class Movie < ApplicationRecord
  has_many :screenings, dependent: :restrict_with_error

  validates :title, :duration_minutes, presence: true
  validates :duration_minutes, numericality: { only_integer: true, greater_than: 0 }
end
