# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Admin user
User.find_or_create_by(email: "bdrums@gmail.com") do |user|
  user.admin = true
  user.confirmed_at = Time.current
  user.first_name = "Brian"
  user.last_name = "Weaver"
  user.password_digest = BCrypt::Password.create(Rails.application.credentials.admin[:password])
end
