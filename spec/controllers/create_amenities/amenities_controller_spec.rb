require "rails_helper"
RSpec.describe AmenitiesController do
  let(:venue) {FactoryGirl.create :venue}

  describe "GET #index" do
    it "select all price_types and render index" do
      get :index, {venue_id: venue.id}, price_types: PriceType.all
    end
  end

  describe "GET #new" do
    let(:amenity) {FactoryGirl.create :amenity}
    let(:invalid_venue) {FactoryGirl.create(:venue, name: nil)}

    it "assigns a new Amenity" do
      get :new, {venue_id: venue.id}
      response.should render_template :new
    end
  end

  describe "POST #create" do
    it "Create a new Amenity successfully" do
      expect {post :create, {venue_id: venue.id,
        amenity: FactoryGirl.attributes_for(:amenity)}}
        .to change(Amenity, :count).by(1)
    end

    it "Does not create new Amenity successfully" do
      expect {post :create, {venue_id: venue.id,
        amenity: FactoryGirl.attributes_for(:amenity, name: nil)}}
        .to_not change(Amenity, :count)
    end

    it "expect to display flash fail" do
      post :create, {params: {venue_id: 4}}
      expect(flash[:danger]).not_to be_empty
    end
  end

  describe "PUT #update" do
    let(:amenity) {FactoryGirl.create(:amenity)}

    it "changes amenity's attributes" do
      put :update, {venue_id: venue.id, id: amenity,
        amenity: FactoryGirl.attributes_for(:amenity)}
      amenity.reload
      expect(flash[:success]).not_to be_empty
    end

    it "render JSON" do
      expected = {price: amenity.service_charge.price,
        per: amenity.service_charge.quantity,
        type: amenity.service_charge.price_type.content}.to_json
      put :update, {venue_id: venue.id, id: amenity.id,
        amenity: FactoryGirl.attributes_for(:amenity), format: :json}
      response.body.should == expected
    end
  end

  describe "DELETE #destroy" do
    let(:amenity) {FactoryGirl.create(:amenity)}
    let(:default_amenity) {FactoryGirl.create(:amenity, is_default: true)}
    let(:venue_amenity) {FactoryGirl.create(:venue_amenity,
      amenity_id: default_amenity.id, venue_id: venue.id)}

    it "delete amenity successfully" do
      delete :destroy, {venue_id: venue.id,
        id: amenity.id}
        expect(flash[:success]).not_to be_empty
    end
    it "delete default amenity successfully" do
      venue_amenity
      delete :destroy, {venue_id: venue.id, id: default_amenity.id}
      expect(flash[:success]).not_to be_empty
    end

    it "delete default amenity unsuccessfully" do
      delete :destroy, {venue_id: 4, id: 1}
      expect(flash[:danger]).not_to be_empty
    end
  end
end
