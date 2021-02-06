class ChargesController < ApplicationController
    def create

        Stripe.api_key = 'sk_test_51HiAyvBu8aPdLWzIbgCyytFnkxjMhN18AcgxanRUboljvzLcbvXgHYzVuWI9TKWrh1SgRFJcSQspeLc0LFv9FBi200meblS75G'

        bookings = User.find(params[:user_id]).bookings.all
        amount = bookings.sum(:total).to_i * 100

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
