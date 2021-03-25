Booking.destroy_all
Artist.destroy_all
Availability.destroy_all
Location.destroy_all
User.destroy_all
Conversation.destroy_all
Message.destroy_all
Category.destroy_all
ArtistCategory.destroy_all

# User
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Name.first_name + "@yopmail.com",
    password: "azerty",
  )
  puts "Create User"
end

#Location
["Nord", "Rhône", "Finistère", "Gironde", "Paris"].each do |departement|
  location = Location.create!(
    department: departement,
  )
  puts "Create location"
end

#Categories
10.times do
  Category.create!(label: Faker::Music.unique.genre)
  puts "Create category"
end

#Artists
30.times do
  artist = Artist.create!(
    artist_name: Faker::Music.band,
    description: Faker::Lorem.sentence(word_count: rand(10..20)),
    hourly_price: rand(20..200),
    email: Faker::Name.first_name + "@yopmail.com",
    password: "azerty",
    location: Location.all.sample,
    status: "approved",

  )
  image_index = rand(1..11)
  artist.avatar.attach(io: File.open("app/assets/images/default_pictures/artist_#{image_index}.jpg"), filename: "artist_#{image_index}.jpg")
  artist.categories << Category.all.sample(rand(1..3))
  puts "Create Artist"
end

#Availability
index = Artist.first.id
30.times do
  start_date = Faker::Time.between(from: DateTime.now, to: DateTime.now + 100)
  availability = Availability.create!(
    start_date: start_date,
    end_date: start_date + 20.days,
    artist: Artist.find(index),
  )
  puts "Create Availability"
  index += 1
end

#Booking
Artist.all.each do |artist|
  Booking.create!(
    start_date: Faker::Time.between(from: artist.availabilities.first.start_date, to: artist.availabilities.first.end_date - 1.day, format: :default),
    duration: 24,
    description: Faker::Lorem.sentence(word_count: 8),
    user: User.all.sample,
    artist: artist,
    status: ["pending", "approved"].sample,
  )
  puts "Create booking"

  index += 1
end



#Reviews
Booking.all.each do |booking|
  Review.create!(
    rating: rand(0..5),
    comment: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
    booking: booking,
    artist: booking.artist,
    user: booking.user,
  )
  puts "Create review"
end

