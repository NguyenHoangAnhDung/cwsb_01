class SpacesController < ApplicationController
  before_action :load_venue, only: [:index]
  def index
  end

  private

  def load_venue
    @venue = Venue.find_by id: params[:venue_id]
    if @venue.nil?
      flash[:danger] = t ".errors.load_venue"
    end
  end
end
