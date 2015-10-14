100.times do
  title = Faker::Commerce.product_name
  description = Faker::Lorem.paragraph
  Product.create!(title: title,
                  description: description)
end
