class Screening < ApplicationRecord
  has_many :reservations, dependent: :restrict_with_error
  has_many :reservation_seats, dependent: :restrict_with_error

  belongs_to :movie
  belongs_to :room

  validate :no_overlapping_screenings
  validates :movie_id, :room_id, :starts_at, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :starts_at, uniqueness: { scope: :room_id }

  private

  def no_overlapping_screenings
    overlapping_screenings = Screening.where(room_id: room_id).where("starts_at < ? AND ends_at > ?", ends_at, starts_at)

    if overlapping_screenings.exists?
      errors.add(:base, "Screening overlaps with another screening in the same room.")
    end
  end
end
