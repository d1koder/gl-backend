class BookingsController < ApplicationController
    # before_action :authenticate_user, except: [:index, :create]
    before_action :set_property, only: [:show, :update, :destroy]
  
    def index
          @bookings = current_user.bookings.all
          render json: @bookings
      end
    end
  
    def create
      @booking = current_user.bookings.build(booking_params)
      if @booking.errors.any?
        render json: @booking.errors, status: :unprocessable_entity
      else
        render json: @booking, status: 201
      end
    end
  
    def show
      render json: @booking
    end
  
    def update
      @booking.update(booking_params)
      if @booking.errors.any?
          render json: @booking.errors, status: :unprocessable_entity
      else 
          render json: @booking, status: 201
      end
    end
  
    def destroy
      @booking.delete
      render json: 204
    end
  
    private
  
    def booking_params
      params.permit(:start_date, :end_date, :property_id, :user_id)
    end
  
    def set_booking
      begin
        @booking = current_user.bookings.find(params[:id])
      rescue
        render json: { error: "Booking not found" }, status: 404
      end
    end


  