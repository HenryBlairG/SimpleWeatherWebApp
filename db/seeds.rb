# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cities = (33..43).map do |n|
  {
    key: '11111',
    name: "Ciudad de Henry #{n}",
    area: "Area de Henry #{n}",
    country: "Pais de Henry #{n}",
    region: "Region de Henry #{n}"
  }
end

City.create(cities)
