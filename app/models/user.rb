class User < ApplicationRecord
    has_many :bookings
    has_many :properties, through: :bookings

    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
end
