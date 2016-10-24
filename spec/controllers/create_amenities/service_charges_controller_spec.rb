require "rails_helper"
RSpec.describe ServiceChargesController do
  let(:venue) {FactoryGirl.create :venue}
  let(:amenity) {FactoryGirl.create :amenity}

  describe "POST #create" do
    it "Create a new Service Charge successfully" do
      expect {post :create, {venue_id: venue.id, amenity_id: amenity.id,
        service_charge: FactoryGirl.attributes_for(:service_charge)}}
        .to change(ServiceCharge, :count).by(1)
    end

    it "Does not create Service Charge successfully" do
      post :create, {venue_id: venue.id, amenity_id: amenity.id,
        service_charge: FactoryGirl.attributes_for(:service_charge, price: nil)}
      expect(flash[:danger]).to_not be_empty
    end
  end

  describe "PUT #update" do
    let(:service_charge) {FactoryGirl.create(:service_charge, price: "143306")}

    it "update Service Charge succesfully" do
      put :update, {venue_id: venue.id, amenity_id: amenity.id,
        id: service_charge,
        service_charge: FactoryGirl.attributes_for(:service_charge)}
      service_charge.reload
      expect(flash[:success]).not_to be_empty
    end

    it "update Service Charge succesfully" do
      put :update, {venue_id: venue.id, amenity_id: amenity.id,
        id: service_charge,
        service_charge: FactoryGirl.attributes_for(:service_charge, price: nil)}
      service_charge.reload
      service_charge.price.should_not eq("143306")
    end

    it "expect to display flash fail when load Amenity" do
      post :create, {params: {venue_id: 306, amenity_id: 143}}
      expect(flash[:danger]).not_to be_empty
    end
  end

end
