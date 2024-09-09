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
Booking.destroy_all
Experience.destroy_all
User.destroy_all

user_image_url = [
  "https://avatars.githubusercontent.com/u/25542223?v=4",
  "https://avatars.githubusercontent.com/u/26819547?v=4",
  "https://avatars.githubusercontent.com/u/34345789?v=4",
  "https://avatars.githubusercontent.com/u/16535142?v=4",
  "https://avatars.githubusercontent.com/u/89939139?v=4",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages-wixmp-ed30a86b8c4ca887773594c2.wixmp.com%2Ff%2F994c107a-87fe-4437-9c27-7f5173301252%2Fd2ti219-eacba25e-59dd-4268-bd47-7decfe7b1772.jpg%2Fv1%2Ffill%2Fw_900%2Ch_831%2Cq_75%2Cstrp%2Fmaster_chief__halo_3_by_zippy5454_d2ti219-fullview.jpg%3Ftoken%3DeyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9ODMxIiwicGF0aCI6IlwvZlwvOTk0YzEwN2EtODdmZS00NDM3LTljMjctN2Y1MTczMzAxMjUyXC9kMnRpMjE5LWVhY2JhMjVlLTU5ZGQtNDI2OC1iZDQ3LTdkZWNmZTdiMTc3Mi5qcGciLCJ3aWR0aCI6Ijw9OTAwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.ghnoaQFh2OgUlu8Tg_MqCNDZEvi5X3S_6Z1SEKSbyds&f=1&nofb=1&ipt=22de073f024d6dfec9444779ff73e047916b643fc296b64463e60a856fb995c3&ipo=images",
  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.1wZeqVjYf8B04zM5E-STwQHaHa%26pid%3DApi&f=1&ipt=fda9d8a05506a8bd06fc4f4dc4afc3a13e1aa8bc4d3600663bab397873288aaa&ipo=images",
  "https://i.pinimg.com/564x/a7/5d/62/a75d62adddc8397c7820df76d8d05a30.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5PjBOJHAm1xl8yejd9mAb20XetMXbioYJiQ&s",
  "https://static01.nyt.com/images/2020/04/14/us/politics/14vid-Obama/14vid-Obama-square640-v3.jpg",
]

# Real image URLs
image_url = {
  "Tokyo Sakura Festival" => [
    "https://images.pexels.com/photos/4151484/pexels-photo-4151484.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/18929393/pexels-photo-18929393/free-photo-of-people-at-the-mitama-festival-at-the-lanterns.jpeg","https://images.pexels.com/photos/9040069/pexels-photo-9040069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/3800118/pexels-photo-3800118.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/1440476/pexels-photo-1440476.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
  ],
  "Gion Matsuri" => ["https://images.pexels.com/photos/1876568/pexels-photo-1876568.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/1325837/pexels-photo-1325837.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/7526797/pexels-photo-7526797.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/5746233/pexels-photo-5746233.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/590478/pexels-photo-590478.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Osaka Night Food Tour" => ["https://images.pexels.com/photos/2070033/pexels-photo-2070033.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/1537635/pexels-photo-1537635.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/3566226/pexels-photo-3566226.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/2070033/pexels-photo-2070033.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/1822605/pexels-photo-1822605.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Hiroshima Peace Memorial Tour" => ["https://images.pexels.com/photos/14331552/pexels-photo-14331552.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/5273004/pexels-photo-5273004.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/22743963/pexels-photo-22743963/free-photo-of-ruins-in-hiroshima-peace-memorial.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/4324951/pexels-photo-4324951.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/2339009/pexels-photo-2339009.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Nara Deer Park and Temple Tour" => ["https://images.pexels.com/photos/18848732/pexels-photo-18848732/free-photo-of-a-deer-standing-next-to-old-stone-statues-in-the-nara-park-nara-japan.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/3408348/pexels-photo-3408348.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/534583/pexels-photo-534583.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/3329812/pexels-photo-3329812.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/1829980/pexels-photo-1829980.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Sapporo Snow Festival" => ["https://images.pexels.com/photos/20187381/pexels-photo-20187381/free-photo-of-sapporo-fushimi-inari-shrine-in-winter.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/1696469/pexels-photo-1696469.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/1719571/pexels-photo-1719571.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/1216475/pexels-photo-1216475.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/16226404/pexels-photo-16226404/free-photo-of-kiyomizu-dera-temple-in-kyoto-japan.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Okinawa Cultural and Historical Tour" => ["https://images.pexels.com/photos/19658288/pexels-photo-19658288/free-photo-of-ceramic-traditional-japanese-dog-statue.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/9808156/pexels-photo-9808156.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/9881552/pexels-photo-9881552.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/8582258/pexels-photo-8582258.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/14809611/pexels-photo-14809611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Nagano Zenko-ji Temple Tour" => ["https://images.pexels.com/photos/25526698/pexels-photo-25526698/free-photo-of-five-storied-pagoda-in-tokyo.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/18848550/pexels-photo-18848550/free-photo-of-buddha-statues-decorated-with-red-caps-near-kanmangafuchi-abyss-nikko-japan.jpeg?auto=compress&cs=tinysrgb&w=1200","https://images.pexels.com/photos/18848565/pexels-photo-18848565/free-photo-of-row-of-stone-buddha-statues-decorated-with-red-caps-and-bibs-nikko-tochigi-japan.jpeg?auto=compress&cs=tinysrgb&w=1200","https://images.pexels.com/photos/21928625/pexels-photo-21928625/free-photo-of-shinkyo-bridge-in-autumn.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/16660195/pexels-photo-16660195/free-photo-of-forest-around-kinkaku.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Nikko World Heritage Tour" => ["https://images.pexels.com/photos/18848548/pexels-photo-18848548/free-photo-of-part-of-the-rinno-ji-temple-nikko-japan.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/1371360/pexels-photo-1371360.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/691637/pexels-photo-691637.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/25998453/pexels-photo-25998453/free-photo-of-people-on-street-in-tokyo.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/14809611/pexels-photo-14809611.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
  "Fukuoka Hakata Gion Yamakasa" => ["https://images.pexels.com/photos/7968193/pexels-photo-7968193.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1","https://images.pexels.com/photos/15829424/pexels-photo-15829424/free-photo-of-couple-sitting-on-a-bench-and-looking-at-mount-fuji.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/22857132/pexels-photo-22857132/free-photo-of-a-snowcapped-mount-fuji-japan.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/5197153/pexels-photo-5197153.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/210547/pexels-photo-210547.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"],
}

# Event details
experiences = [
  { location: "Tokyo", title: "Tokyo Sakura Festival", content: "Enjoy the **enchanting** cherry blossom season with a guided tour through Ueno Park. Begin your journey with an early morning stroll beneath the blooming sakura trees, where the air is filled with the sweet scent of cherry blossoms. The tour includes a traditional tea ceremony, where you'll learn about the art of Japanese tea making and experience the serene ritual firsthand. As the day progresses, you'll explore hidden corners of the park, discovering local street food vendors offering a variety of seasonal treats such as sakura mochi and matcha-flavored sweets. The tour concludes with a breathtaking evening illumination, where the cherry blossoms are lit up, creating a magical atmosphere that is truly unforgettable." },
  { location: "Kyoto", title: "Gion Matsuri", content: "Experience the **vibrant** Gion Matsuri, one of Japan's most famous festivals, with a guided walk through the historical streets of Kyoto. The festival, which dates back over a thousand years, is a celebration of the city's rich cultural heritage. As you walk through the streets, you'll encounter the grand **Yamaboko floats**, which are intricately decorated with tapestries, carvings, and other ornate details. These floats are a testament to the city's craftsmanship and artistic tradition. Your guide will take you behind the scenes, where you'll meet local artisans and learn about the painstaking process of creating these floats. In the evening, you'll have the rare opportunity to visit a traditional tea house, where you'll be treated to an exclusive performance by a geisha, offering a glimpse into Kyoto's storied past." },
  { location: "Osaka", title: "Osaka Night Food Tour", content: "Explore Osaka's renowned food scene with a night tour that takes you through the bustling streets of Dotonbori. Begin your culinary adventure by sampling **delicious** Takoyaki, a popular street food made from batter and filled with diced octopus, green onions, and pickled ginger. As you continue your tour, you'll try Okonomiyaki, a savory pancake filled with a variety of ingredients, and other local delights that showcase Osaka's diverse food culture. The tour also includes a visit to a hidden **Izakaya**, where you'll taste rare **sake** and learn about the history and tradition behind this beloved Japanese drink. The evening ends with a sweet treat, as you sample some of Osaka's famous desserts while taking in the vibrant night atmosphere of the city." },
  { location: "Hiroshima", title: "Hiroshima Peace Memorial Tour", content: "Join a **deeply moving** guided tour of the Hiroshima Peace Memorial Park and Museum. Begin your visit with a solemn walk through the park, where you'll see the iconic **A-Bomb Dome**, a powerful reminder of the devastation caused by the atomic bombing. The tour includes a visit to the museum, where you'll learn about the history and impact of the bombing through exhibits that include personal stories, photographs, and artifacts from the time. You'll also have the opportunity to meet with survivors, known as hibakusha, who will share their experiences and insights on the importance of peace and nuclear disarmament. The tour concludes with a reflective moment at the **Cenotaph for the A-bomb Victims**, where you can pay your respects to those who lost their lives." },
  { location: "Nara", title: "Nara Deer Park and Temple Tour", content: "Spend a day visiting Nara's famous Todai-ji Temple and feeding the **friendly** deer in Nara Park. Your tour begins with a guided visit to Todai-ji, home to the world's largest bronze statue of Buddha, known as Daibutsu. As you explore the temple grounds, your guide will provide insights into the history and significance of this UNESCO World Heritage site, which dates back to the 8th century. After visiting the temple, you'll have the opportunity to interact with the free-roaming deer in Nara Park, which are considered sacred in Japanese culture. The deer are known for bowing to visitors in exchange for food, a behavior that has become a beloved tradition. The tour concludes with a peaceful stroll through the park, where you can enjoy the natural beauty of the area and learn more about Nara's role as the ancient capital of Japan." },
  { location: "Sapporo", title: "Sapporo Snow Festival", content: "Witness the **incredible** snow and ice sculptures at the Sapporo Snow Festival with a guided tour. This world-famous event, held annually in February, attracts visitors from all over the globe. Begin your tour with a visit to **Odori Park**, the festival's main site, where you'll see towering snow sculptures that depict everything from famous landmarks to characters from popular culture. As you walk through the park, your guide will share stories about the history of the festival and the artists who create these stunning works of art. The tour also includes a visit to the **Susukino** site, known for its impressive ice sculptures. In the evening, you'll enjoy a relaxing soak in a nearby hot spring, where you can warm up and unwind after a day of exploring. The tour concludes with a visit to a local restaurant, where you'll sample Hokkaido's famous seafood, including fresh crab and scallops." },
  { location: "Okinawa", title: "Okinawa Cultural and Historical Tour", content: "Discover Okinawa's unique culture and history with a comprehensive tour that takes you to some of the region's most iconic sites. Begin your journey with a visit to **Shurijo Castle**, a UNESCO World Heritage site that was once the center of the Ryukyu Kingdom. As you explore the castle's grounds, your guide will explain the significance of this historic site and its role in Okinawa's history. Next, you'll visit a local market, where you can sample traditional Okinawan foods and browse for unique souvenirs. The tour also includes a visit to a traditional Ryukyu village, where you'll have the opportunity to watch a **Ryukyu dance performance** and learn about the island's cultural traditions. The day concludes with a visit to a serene beach, where you can relax and enjoy the stunning ocean views." },
  { location: "Nagano", title: "Nagano Zenko-ji Temple Tour", content: "Explore the ancient Zenko-ji Temple in Nagano with a guided tour that offers both cultural insights and opportunities for personal reflection. Begin your visit with a **meditative** session led by a local monk, who will guide you through the principles of Zen meditation and mindfulness. After the session, you'll have the chance to explore the temple's extensive grounds, which include a number of historic buildings and sacred sites. Your guide will share stories about the temple's history and the legends associated with it, providing a deeper understanding of its significance. The tour also includes a walk through the temple's **underground passage**, known as the O-kaidan, where visitors can experience total darkness and seek the 'key to paradise.' The day concludes with a visit to a nearby **onsen**, where you can relax and soak in the natural hot spring waters while taking in views of the surrounding mountains." },
  { location: "Nikko", title: "Nikko World Heritage Tour", content: "Visit the UNESCO World Heritage sites in Nikko with a guided tour that showcases the region's natural beauty and historical significance. Begin your journey with a visit to the **magnificent** Toshogu Shrine, a mausoleum dedicated to Tokugawa Ieyasu, the founder of the Tokugawa shogunate. The shrine is known for its lavish decorations and intricate carvings, which your guide will explain in detail. After exploring the shrine, you'll take a scenic drive through the mountains to visit **Kegon Falls**, one of Japan's most famous waterfalls. The tour also includes a visit to **Lake Chuzenji**, where you can enjoy a peaceful boat ride and take in the stunning views of the surrounding mountains. As you travel through the region, your guide will share stories about the area's history and its importance in Japanese culture. The day concludes with a visit to a traditional ryokan, where you can relax and enjoy a kaiseki meal, a multi-course dinner that highlights local ingredients and seasonal flavors." },
  { location: "Fukuoka", title: "Fukuoka Hakata Gion Yamakasa", content: "Experience the **thrilling** Hakata Gion Yamakasa festival with a guided tour that takes you deep into the heart of Fukuoka's cultural traditions. The festival, which dates back over 700 years, is known for its elaborate races, where teams of men carry massive floats through the streets at breakneck speeds. Your tour begins with a visit to a local shrine, where you'll learn about the rituals and preparations that go into the festival. As you walk through the city, your guide will take you to key sites related to the festival, including the **Kushida Shrine**, where the main events take place. You'll also have the opportunity to meet with festival participants, who will share their experiences and the significance of this event in their lives. The tour includes a stop at a traditional **yatai**, or food stall, where you can sample local dishes such as Hakata ramen and mentaiko, a spicy cod roe. The day concludes with a visit to a local museum, where you can view historic artifacts related to the festival and gain a deeper understanding of its cultural importance." }

]

# Fake reviews
reviews = [
  "The tour was amazing! Our guide was knowledgeable and friendly. Highly recommend!",
  "Had a fantastic time. The itinerary was well-planned and the sights were breathtaking.",
  "Great experience! The guide made sure everyone was comfortable and engaged.",
  "Loved every moment of the tour. The guide's stories were fascinating.",
  "A wonderful tour with beautiful scenery. The guide was very attentive and informative.",
  "The tour exceeded my expectations. The guide was excellent and the group was fun.",
  "An unforgettable experience. The guide was professional and the tour was well-organized.",
  "Enjoyed every part of the tour. The guide was friendly and the locations were stunning.",
  "Fantastic tour! The guide was knowledgeable and the pace was perfect.",
  "A great way to see the city. The guide was engaging and the tour was very enjoyable."
]

# Fake guide intros
guide_intros = [
  "Passionate about sharing the hidden gems of our city, I bring history and culture to life on every experience.",
  "With over 10 years of sharing my city to visitors, I ensure each experience is an unforgettable adventure filled with fascinating stories.",
  "As a local expert, I love showcasing the unique charm and beauty of our region to visitors from around the world.",
  "Join me for an engaging and informative journey through our city's most iconic landmarks and secret spots.",
  "Dedicated to paying homage to my roots, I blend historical facts with captivating anecdotes.",
  "I specialize in creating personalized experiences that cater to your interests, making each visit truly special.",
  "With a background in history and a passion for storytelling, I make every experience both educational and entertaining.",
  "Explore the city with me and discover its rich heritage, vibrant culture, and stunning architecture.",
  "I take pride in offering experiences that are not only informative but also fun and interactive for all ages.",
  "Let me guide you through an immersive experience that highlights the best our city has to offer.",
  "As a seasoned guide, I aim to make each experience a memorable and enriching experience for all my guests.",
  "My experiences are designed to be immersive and engaging, offering a deep dive into the local culture and history.",
  "With a passion for travel and storytelling, I bring a unique perspective to every experience I lead.",
  "I love meeting new people and sharing the fascinating stories and hidden gems of our city.",
  "Join me for a experience that combines historical insights with fun facts and local anecdotes.",
  "I strive to create a welcoming and enjoyable atmosphere on all my experiences, ensuring everyone has a great time.",
  "With a background in archaeology, I offer a unique and informed perspective on our city's ancient sites.",
  "My goal is to provide an unforgettable experience that leaves you with lasting memories.",
  "I take pride in offering experiences that are both informative and entertaining, tailored to your interests.",
  "Let me show you the best our city has to offer, from iconic landmarks to hidden treasures."
]

# create two users - guide and traveller

puts "Creating users!"

10.times do |index|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '123123' # needs to be at least 6 characters
  )
  file = URI.open(user_image_url[index])
  user.avatar.attach(io: file, filename: "user-#{index + 1}.jpeg", content_type: 'image/jpeg')
end


puts "Created #{User.count} users!"
puts "Creating experiences!"

experiences.each do |experience|
  exp = Experience.create!(
    location: experience[:location],
    title: experience[:title],
    content: experience[:content],
    photo_url: image_url[experience[:title]],
    price: rand(2000..5000),
    duration: rand(2..10),
    user: User.all.sample,
    latitude: 35.652832 + rand(0.01..0.06),
    longitude: 139.839478 + rand(0.1..0.6)
  )
  image_url[experience[:title]].each_with_index do |url, index|
    file = URI.open(url)
    exp.photos.attach(io: file, filename: "#{experience[:title].parameterize}-#{index + 1}.jpeg", content_type: 'image/jpeg')
  end
end

puts "Created #{Experience.count} experiences!"
puts "Creating bookings!"

10.times do
  Booking.create!(
    experience: Experience.all.sample,
    user: User.all.sample,
    date: Date.today,
    status: rand(1..3) # needs to be at least 6 characters
  )
end

puts "Created #{Booking.count} bookings!"
puts "Creating reviews!"

20.times do
  experience = Experience.all.sample
  Review.create!(
    experience: experience,
    user: User.where.not(id: experience.user).sample,
    content: reviews.sample,
    rating: rand(3..5),
    )
end

puts "Created #{Review.count} reviews!"

puts "Creating guide intros!"

# Selecting only users providing at least one experience
guide_users = User.joins(:experiences).group('users.id').having('COUNT(experiences.id) > 0')

# giving each of the guides an intro statement

guide_users.each do |guide|
  guide.guide_intro = guide_intros.sample
  guide.save!
end

puts "Guide intros created for #{guide_users.to_a.count} users with experiences!"

puts "FYI: #{guide_users.to_a.count} out of #{User.count} users are guides."
