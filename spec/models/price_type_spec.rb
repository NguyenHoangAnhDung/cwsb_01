require 'rails_helper'

RSpec.describe PriceType, type: :model do
  context "associations" do
    it {is_expected.to have_many :service_charges}
    it {is_expected.to have_many :amenities}
  end
end
