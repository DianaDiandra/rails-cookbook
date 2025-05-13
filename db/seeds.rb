# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Recipe.create!([
  {
    name: "Spaghetti Bolognese",
    description: "Classic Italian pasta dish.",
    image_url: "https://example.com/images/spaghetti.jpg",
    rating: 5
  },
  {
    name: "Chickpeas Tikka Masala",
    description: "Creamy spiced curry.",
    image_url: "https://example.com/images/tikka.jpg",
    rating: 4
  },
  {
    name: "Veggie Stir Fry",
    description: "Mixed vegetables sautéed in a savory soy-ginger sauce.",
    image_url: "https://example.com/images/stirfry.jpg",
    rating: 3
  },
  {
    name: "Avocado Toast",
    description: "Toasted bread topped with mashed avocado and seasoning.",
    image_url: "https://example.com/images/avocado.jpg",
    rating: 4
  }
])

categories = ["Italian", "Breakfast", "Lunch"]

categories.each do |name|
  Category.find_or_create_by(name: name)
end
