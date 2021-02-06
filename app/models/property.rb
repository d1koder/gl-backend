class Property < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings

    has_one_attached :featured_image
end
