# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Destroying old records'
User.destroy_all
puts 'Seeding started'
puts 'Creating User and Listings'
user1 = User.create(username: 'daniel', email:'daniel@coder.edu', password:'password')

4.times do
  user1.listings.create(
    name: Faker::Drone.name,
    description:'TODO',
    weight: Faker::Drone.weight,
    max_speed: Faker::Drone.max_speed,
    price: rand(200.0.. 5_000.0),
    battery_capacity: Faker::Drone.battery_capacity,
    status: 1
  )
end

puts 'Seeding complete'