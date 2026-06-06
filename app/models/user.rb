class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = [ "customer", "employee" ].freeze

  has_many :reservations, dependent: :restrict_with_error

  validates :role, presence: true, inclusion: { in: ROLES }
end
