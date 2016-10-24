class VenueAmenity < ApplicationRecord
  belongs_to :venue
  belongs_to :amenity

  scope :select_belongs_to, ->(amenity_id, venue_id) do
    find_by amenity_id: amenity_id, venue_id: venue_id
  end
end
