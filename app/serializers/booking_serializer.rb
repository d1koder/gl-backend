class BookingSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :property_id, :user_id
end
