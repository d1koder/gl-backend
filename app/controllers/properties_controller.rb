class PropertiesController < ApplicationController
    before_action :authenticate_user, except: [:index, :show]
    before_action :set_property, only: [:show, :update, :destroy]

    def index
        @properties = Property.all
        render json: @properties
    end
    
    def create
        @property = Property.create(property_params)
        if @property.errors.any?
            render json: @property.errors, status: :unprocessable_entity
        else 
            render json: @property, status: 201
        end
    end

    private
    def property_params
        params.permit(:title, :description, :featured_image, :category_id, :rate)
    end
    
    def set_property
        begin
            @property = Property.find(params[:id])
        rescue 
            render json: {error: "Property not found"}, status: 404
        end
      end
end

#this is a comment tedt
#this is another test
