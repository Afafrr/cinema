class User < ApplicationRecord
  ROLES = [ "customer", "employee" ].freeze

  has_many :reservations, dependent: :restrict_with_error

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :role, presence: true, inclusion: { in: ROLES }
end
