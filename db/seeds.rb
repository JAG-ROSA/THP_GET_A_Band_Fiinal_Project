# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'Faker'
Artist.destroy_all
Availability.destroy_all
Booking.destroy_all
Location.destroy_all
User.destroy_all

# Admin
1.times do
  admin = User.create!(
    first_name: "getabandadmin",
    last_name: Faker::Name.last_name,
    email: "getabandadmin@yopmail.com",
    password: "azerty",
    admin: true,
  )
  puts "Create Admin"
end

# User
5.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Name.first_name + "@yopmail.com",
    password: "azerty",
  )
  puts "Create User"
end

#Location
5.times do
  location = Location.create!(
    department: ["Oise", "Val-d'oise", "Finistère", "Bouches-du-Rhône", "Paris"].sample,
  )
  puts "Create location"
end

#Artits
5.times do
  artist = Artist.create!(
    artist_name: Faker::Kpop.iii_groups,
    description: Faker::Lorem.sentence(word_count: 8),
    hourly_price: 50,
    email: Faker::Name.first_name + "@yopmail.com",
    password: "azerty",
    location: Location.all.sample,
    status: ["pending", "approved", "suspended"].sample,

  )
  puts "Create Artist"
end

#Availability
5.times do
  start_date = Faker::Time.between(from: DateTime.now, to: DateTime.now + 100)
  availability = Availability.create!(
    start_date: start_date,
    end_date: start_date + rand(1..20).days,
    status: [true, false].sample,
    artist: Artist.all.sample,
  )
  puts "Create Availability"
end

#Booking
5.times do
  booking = Booking.create!(
    start_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 100, format: :default),
    duration: 24,
    description: Faker::Lorem.sentence(word_count: 8),
    user: User.all.sample,
    availability: Availability.all.sample,
    status: ["payment_pending", "paid", "payment_rejected"].sample,
  )
  puts "Create booking"
end
