class PropertiesController < ApplicationController
  # before_action :authenticate_user, except: [:index, :create]
  before_action :set_property, only: [:show, :update, :destroy]

  def index
    @properties = Property.all

    if params[:keyword] && params[:keyword] != ""
      # p params[:keyword]
      @properties = @properties.where("title ILIKE ?", "%#{params[:keyword]}%")      
    end
        
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

  def show
    render json: @property
  end

  def update
    @property.update(property_params)
    if @property.errors.any?
        render json: @property.errors, status: :unprocessable_entity
    else 
        render json: @property, status: 201
    end
  end

  def destroy
    @property.delete
    render json: 204
  end

  private

  def property_params
    params.permit(:title, :description, :featured_image, :category_id, :rate, :location)
  end

  def set_property
    begin
      @property = Property.find(params[:id])
    rescue
      render json: { error: "Property not found" }, status: 404
    end
  end
end

#this is a comment tedt
#this is another test
