class Property < ApplicationRecord
    has_many :bookings
    has_many :users, through: :bookings

    has_one_attached :featured_image

    # def self.find_by_category(input)
    #     category = Category.find_by(name: input.capitalize)
    #     return self.where(category: category)
    #   end
end
