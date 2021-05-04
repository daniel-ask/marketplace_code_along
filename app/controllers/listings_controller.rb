class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @listings = Listing.active
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    @listing.status = 1
    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def edit
  end

  def show
    @listing = Listing.find(params[:id])
  end

  private

  def listing_params
    params.require(:listing).permit(:name,:price,:max_speed,:battery_capacity,:weight,:description)
  end
end
