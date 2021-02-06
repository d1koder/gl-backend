class Booking < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :start_date, presence: true, uniqueness: true
  validates :end_date, presence: true, uniqueness: true

  validate :no_booking_overlap

  def no_booking_overlap
    if (Booking.where("(? BETWEEN start_date AND end_date OR ? BETWEEN start_date AND end_date) AND user_id = ?", self.start_date, self.end_date, self.user_id).any?)
      errors.add(:end_date, "it overlaps another booking")
    end
  end
end
