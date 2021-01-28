class PropertySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :featured_image, :category_id, :rate

  def featured_image
    if object.featured_image.attached?
       rails_blob_url(object.featured_image)
    end
  end
end
