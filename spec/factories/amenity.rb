FactoryGirl.define do
  factory :amenity do
    name Faker::Name.name
    venue
    is_default false
    service_charge
  end
end
