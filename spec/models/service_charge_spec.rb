require 'rails_helper'

RSpec.describe ServiceCharge, type: :model do
  context "associations" do
    it {is_expected.to belong_to :amenity}
    it {is_expected.to belong_to :price_type}
  end
end
