class Reservation < ApplicationRecord
  STATUSES = [ "active", "cancelled" ].freeze

  has_many :reservation_seats, dependent: :destroy

  belongs_to :user
  belongs_to :screening

  validates :user_id, :screening_id, :status, presence: true
  validates :status, inclusion: { in: STATUSES }
end
