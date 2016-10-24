FactoryGirl.define do
  factory :service_charge do
    price_type
    price {Faker::Number.number(3)}
    quantity {Faker::Number.number(2)}
  end
end
