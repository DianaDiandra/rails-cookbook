# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

puts "Cleaning up database..."
Bookmark.destroy_all
Recipe.destroy_all
puts "Database cleaned."

CATEGORIES = ["Breakfast", "Pasta", "Seafood", "Dessert"]

def recipe_builder(id, category)
  url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  response = URI.open(url).read
  data = JSON.parse(response)
  meal = data["meals"].first

  recipe = Recipe.create!(
  name: meal["strMeal"],
  description: meal["strInstructions"],
  image_url: meal["strMealThumb"],
  rating: rand(1..5)
)

  Bookmark.create!(
    recipe: recipe,
    category: category,
    comment: "Seeded from API"
  )
end

  CATEGORIES.each do |category_name|
    puts "Fetching recipes for category: #{category_name}"

    category = Category.create!(name: category_name)

    url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category_name}"
    response = URI.open(url).read
    data = JSON.parse(response)

    data["meals"].each do |meal|
      id = meal["idMeal"]
      puts "Building recipe with ID: #{id}"
      recipe_builder(id, category)
    end

    puts "--- End of #{category_name} ---"
  end
# [
#   {
#     name: "Spaghetti Bolognese",
#     description: "Classic Italian pasta dish.",
#     image_url: "https://media.istockphoto.com/id/632439546/photo/pasta-plate.jpg?s=2048x2048&w=is&k=20&c=lz-xvg4EbUszcA2MoIEUZKNJDdBwry0WTjHD1B4O1k8=",
#     rating: 5
#   },
#   {
#     name: "Chickpeas Tikka Masala",
#     description: "Creamy spiced curry.",
#     image_url: "https://media.istockphoto.com/id/1445673298/photo/cooked-chickpea-in-frying-pan-with-curry-and-spices-homemade-vegan-chickpeas-healthy-food.jpg?s=2048x2048&w=is&k=20&c=sZJFDDEoBOq2MoxMttXDOhJ7ZL7FV8A7nrVb2V4Jb3o=",
#     rating: 4
#   },
#   {
#     name: "Tofu Stir Fry",
#     description: "Mixed vegetables sautéed in a savory soy-ginger sauce.",
#     image_url: "https://media.istockphoto.com/id/523445425/photo/homemade-tofu-stir-fry.jpg?s=2048x2048&w=is&k=20&c=D8eXIYwiq8IMZRU_CnUq7hKScz5TA4pqQdyY_kZNVrg=",
#     rating: 3
#   },
#   {
#     name: "Avocado Toast",
#     description: "Toasted bread topped with mashed avocado and seasoning.",
#     image_url: "https://images.unsplash.com/photo-1505575156881-dd15ae275636?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGF2b2NhZG8lMjB0b2FzdHxlbnwwfHwwfHx8MA%3D%3D",
#     rating: 4
#   }
# ].each do |attrs|
#   Recipe.find_or_create_by!(name: attrs[:name]) do |recipe|
#     recipe.description = attrs[:description]
#     recipe.image_url = attrs[:image_url]
#     recipe.rating = attrs[:rating]
#   end
# end

# categories = ["Italian", "Breakfast", "Lunch"]

# categories.each do |name|
#   Category.find_or_create_by(name: name)
# end
