FactoryGirl.define do
  factory :user do
    name      "Example User"
    email     "user@example.com"
    password  "foobar"
    password_confirmation "foobar"
  end

  factory :product do
    sequence(:title) { |n| "Example Product #{n}" }
    description Faker::Lorem.paragraph
  end
end
