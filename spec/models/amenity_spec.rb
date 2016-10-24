require "rails_helper"
RSpec.describe Amenity, type: :model do
  context "associations" do
    it {is_expected.to have_many :venue_amenities}
    it {is_expected.to have_many :images}
    it {is_expected.to have_many :venues}
    it {is_expected.to have_one :service_charge}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}

    it "is create VenueAmenity after create Amenity" do
      FactoryGirl.create(:amenity)
      expect(VenueAmenity.count).to eq(1)
    end
  end
end
