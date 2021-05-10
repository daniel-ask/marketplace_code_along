class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_listing, only: [:show]
  before_action :authorize_listing, only: [:edit, :update, :destroy, :deactivate]

  def index
    @listings = Listing.active
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def deactivate
    flash[:alert] = 'unable to deactivate listing' unless @listing.update(status: 'inactive')
    redirect_to @listing
  end

  def show
    stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      client_reference_id: current_user.id,
      customer_email: current_user.email,
      line_items:[{ 
        amount: (@listing.price * 100).to_i,
        name: @listing.name,
        description: @listing.description,
        currency: 'aud',
        quantity: 1,
        images: @listing.images.empty? ? nil : [@listing.images.first.service_url]
       }],
       payment_intent_data: { 
         metadata: { 
           listing_id: @listing.id,
           user_id: current_user.id
          }
        },
        success_url: "#{root_url}purchases/success?listingId=#{@listing.id}",
        cancel_url: "#{root_url}listings"
    )
    @session_id = stripe_session.id
  end

  def destroy
    @listing.destroy
    flash[:alert] = 'Successfully Destroyed'
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:listing).permit(:name, :price, :max_speed, :battery_capacity, :weight, :description, images: [])
  end

  def authorize_listing
    @listing = current_user.listings.find_by_id(params[:id])
    return if @listing

    flash[:alert] = 'YOU ARE NOT ALLOWED TO DO THIS'
    redirect_to listings_path
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end
