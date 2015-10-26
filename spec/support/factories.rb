FactoryGirl.define do
  factory :user do
    name      "Example User"
    email     "user@example.com"
    password  "foobar"
    password_confirmation "foobar"

    after(:create) { |user| create(:cart, user: user) }
  end

  factory :product do
    sequence(:title) { |n| "Example Product #{n}" }
    description Faker::Lorem.paragraph
  end

  factory :cart do
    user
  end

  factory :cart_item do
    cart
    product
  end
end
