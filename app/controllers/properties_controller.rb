class PropertiesController < ApplicationController
    def index
        @properties = Property.all
        render json: @properties
    end
    def create
        @property = Property.create(property_params)
    end
    private
    def property_params
        params.permit(:title, :description, :featured_image, :category_id)
    end
end