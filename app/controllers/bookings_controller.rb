class BookingsController < ApplicationController
  before_action :authenticate_user!
  load_resource

  def index
    @bookings = Booking.current_order(current_user)
      .group_by{|booking| booking.space.venue}
  end

  def create
    @booking = Booking.new booking_params
    @booking.save
  end

  def update
    respond_to do |format|
      @booking.update_attributes booking_params
      flash[:success] = t "amenities.new.edit_success"
      format.html {redirect_to store_bookings_path}
      format.json do
        render json: {
        }
      end
    end
  end

  private
  def booking_params
    params.require(:booking).permit(:space_id, :booking_from, :duration,
      :booking_type_id, :quantity, :state).merge! user: current_user
  end
end
