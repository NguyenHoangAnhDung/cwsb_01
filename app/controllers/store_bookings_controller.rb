class StoreBookingsController < ApplicationController
  def index
    binding.pry
    @venues = current_user.venues
  end
end
