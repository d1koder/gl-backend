class PropertiesController < ApplicationController
    def index
        @properties = Property.all
        render json: @properties
    end
    
    def create
        @property = Property.create(property_params)
        if @property.error.any?
            render json: @property.errors, status: :unprocessable_entity
        else 
            render json: @property, status: 201
        end
    end

    private
    def property_params
        params.permit(:title, :description, :featured_image, :category_id, :rate)
    end
end