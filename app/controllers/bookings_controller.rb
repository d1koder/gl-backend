class BookingsController < ApplicationController
  before_action :authenticate_user, except: [:index, :create]
  before_action :set_booking, only: [:show, :update, :destroy]
  before_action :check_ownership, only: [:update, :destroy]

  def index
      @bookings = current_user.bookings.all.joins(:property).pluck(Arel.sql("properties.title, properties.location, bookings.start_date, bookings.end_date, bookings.id, bookings.total")).map { |p| { title: p[0], location: p[1], start_date: p[2], end_date: p[3], id: p[4], total: p[5] } }

      render json: @bookings
  end

  def create
    selected_property = Property.find(params[:property_id])
    @booking = current_user.bookings.build(booking_params)

    total = (@booking.end_date - @booking.start_date).to_i * selected_property.rate
    @booking.total = total

    @booking.save

    # @booking = current_user.bookings.create(booking_params)
    if @booking.errors.any?
      render json: @booking.errors.full_messages, status: :unprocessable_entity
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
    params.require(:booking).permit(:start_date, :end_date, :property_id, :user_id, :total)
  end

  def set_booking
    begin
      @booking = current_user.bookings.find(params[:id])
    rescue
      render json: { error: "Booking not found" }, status: 404
    end
  end

  def check_ownership
    if current_user.id != @booking.user.id
      render json: { error: "You have no permission to do that" }, status: 401
    end
  end
end
