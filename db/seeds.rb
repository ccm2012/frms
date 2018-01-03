5.times do |n|
  name = Faker::Food.dish
  price = 1000
  description = Faker::Food.ingredient
  available = 1
  Dish.create!(
    name: name,
    price: price,
    description: description,
    available: available
  )
end

5.times do |n|
  name = Faker::Food.dish
  description = Faker::Food.ingredient
  Category.create!(
    name: name,
    description: description
  )
end
