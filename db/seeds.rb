User.destroy_all
City.destroy_all
Listing.destroy_all
Reservation.destroy_all

20.times do
  User.create!(
    email: "user#{rand(1..10000)}@yopmail.com",
    phone_number: "06#{rand(10000000..99999999)}",
    description: "Description de l'utilisateur"
  )
end

10.times do
  City.create!(
    name: ["Paris", "Lyon", "Marseille", "Bordeaux", "Lille"].sample,
    zip_code: "#{rand(10..95)}#{rand(100..999)}"
  )
end

50.times do
  Listing.create!(
    available_beds: rand(1..10),
    price: rand(20..150),
    description: "Ceci est une description de plus de cent quarante caractères pour valider le modèle Listing Airbnb car c'est obligatoire pour le projet THP du jour." * 2,
    has_wifi: [true, false].sample,
    welcome_message: "Bienvenue dans mon humble demeure !",
    admin: User.all.sample,
    city: City.all.sample
  )
end

Listing.all.each do |listing|
  # 5 réservations passées
  5.times do |i|
    start = Time.now - (i + 1).weeks
    Reservation.create(
      start_date: start,
      end_date: start + 2.days,
      guest: User.all.sample,
      listing: listing
    )
  end

  # 5 réservations futures
  5.times do |i|
    start = Time.now + (i + 1).weeks
    Reservation.create(
      start_date: start,
      end_date: start + 2.days,
      guest: User.all.sample,
      listing: listing
    )
  end
end