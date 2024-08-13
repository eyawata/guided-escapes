require 'open-uri'
require 'nokogiri'
require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing data
Experience.destroy_all
User.destroy_all

# Real image URLs
image_url = {
  "Tokyo Sakura Festival" => "https://images.pexels.com/photos/4151484/pexels-photo-4151484.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Gion Matsuri" => "https://images.pexels.com/photos/1876568/pexels-photo-1876568.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Osaka Night Food Tour" => "https://images.pexels.com/photos/2070033/pexels-photo-2070033.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Hiroshima Peace Memorial Tour" => "https://images.pexels.com/photos/14331552/pexels-photo-14331552.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Nara Deer Park and Temple Tour" => "https://images.pexels.com/photos/18848732/pexels-photo-18848732/free-photo-of-a-deer-standing-next-to-old-stone-statues-in-the-nara-park-nara-japan.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Sapporo Snow Festival" => "https://images.pexels.com/photos/20187381/pexels-photo-20187381/free-photo-of-sapporo-fushimi-inari-shrine-in-winter.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Okinawa Cultural and Historical Tour" => "https://images.pexels.com/photos/19658288/pexels-photo-19658288/free-photo-of-ceramic-traditional-japanese-dog-statue.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Nagano Zenko-ji Temple Tour" => "https://images.pexels.com/photos/25526698/pexels-photo-25526698/free-photo-of-five-storied-pagoda-in-tokyo.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Nikko World Heritage Tour" => "https://images.pexels.com/photos/18848548/pexels-photo-18848548/free-photo-of-part-of-the-rinno-ji-temple-nikko-japan.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "Fukuoka Hakata Gion Yamakasa" => "https://images.pexels.com/photos/7968193/pexels-photo-7968193.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
}

# Event details
experiences = [
  { location: "Tokyo", title: "Tokyo Sakura Festival", content: "Enjoy the cherry blossom season with a guided tour through Ueno Park, including traditional tea ceremonies and local street food." },
  { location: "Kyoto", title: "Gion Matsuri", content: "Experience the vibrant Gion Matsuri, one of Japan's most famous festivals, with a guided walk through the historical streets of Kyoto." },
  { location: "Osaka", title: "Osaka Night Food Tour", content: "Explore Osaka's renowned food scene with a night tour that takes you through Dotonbori, sampling Takoyaki, Okonomiyaki, and other local delights." },
  { location: "Hiroshima", title: "Hiroshima Peace Memorial Tour", content: "Join a guided tour of the Hiroshima Peace Memorial Park and Museum, learning about the history and impact of the atomic bombing." },
  { location: "Nara", title: "Nara Deer Park and Temple Tour", content: "Spend a day visiting Nara's famous Todai-ji Temple and feeding the friendly deer in Nara Park, with insights into the city's history." },
  { location: "Sapporo", title: "Sapporo Snow Festival", content: "Witness the incredible snow and ice sculptures at the Sapporo Snow Festival, with a guided tour that includes visits to local hot springs." },
  { location: "Okinawa", title: "Okinawa Cultural and Historical Tour", content: "Discover Okinawa's unique culture and history with visits to Shurijo Castle, local markets, and traditional Ryukyu dance performances." },
  { location: "Nagano", title: "Nagano Zenko-ji Temple Tour", content: "Explore the ancient Zenko-ji Temple in Nagano, including a meditation session and a walk through the temple grounds." },
  { location: "Nikko", title: "Nikko World Heritage Tour", content: "Visit the UNESCO World Heritage sites in Nikko, including Toshogu Shrine, with a guided tour through the beautiful mountainous region." },
  { location: "Fukuoka", title: "Fukuoka Hakata Gion Yamakasa", content: "Experience the excitement of the Hakata Gion Yamakasa festival, with a guided tour of Fukuoka's historical sites and local cuisine." }
]

# create two users - guide and traveller

# 10.times do
#   user = User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: '123123' # needs to be at least 6 characters
#     # add any additional attributes you have on your model
#   )

# end


puts "Creating experience!"

experiences.each do |experience|
  exp = Experience.create!(
    location: experience[:location],
    title: experience[:title],
    content: experience[:content],
    photo_url: image_url[experience[:title]],
    price: rand(2000..5000),
    duration: rand(2..10),
    user: User.all.sample
  )
  end
  puts "Seed data created!"
