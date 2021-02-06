class ChargesController < ApplicationController
    def create

        Stripe.api_key = ENV['STRIPE_SECRET_KEY']

        bookings = current_user.bookings.all.joins(:property).pluck(Arel.sql("properties.title, properties.location, bookings.start_date, bookings.end_date, bookings.id, bookings.total")).map { |p| { title: p[0], location: p[1], start_date: p[2], end_date: p[3], id:p[4], total: p[5] } }
        amount = bookings.sum(:total) * 100

        charge = Stripe::Charge.create(
            :amount => amount,
            :description => 'Gold Label',
            :currency => 'aud',
            :source => params[:token]
        )

    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to charges_path
    end

end
