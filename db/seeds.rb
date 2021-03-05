# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
regions = (0..10).map do |a|
  {
    r_ID: "#{a}",
    r_local_name: "Area de Henry #{a}"
  }
end

countries = (11..21).map do |a|
  { 
    c_ID: "#{a}",
    c_local_name: "Area de Henry #{a}"
  }
end

areas = (22..32).map do |a|
  { 
    a_ID: "#{a}",
    a_local_name: "Area de Henry #{a}"
  }
end

cities = (33..43).map do |n|
  {
    key: "11111",
    gmt: "-6".to_i,
    local_name: "Ciudad de Henry #{n}"
  }
end

regions = Region.create(regions)
regions.each do |r|
  countries = Country.create(countries, region: r)
  countries.each do |c|
    areas = Area.create(areas, country: c)
    areas.each do |a|
      cities = City.create(cities, area: a)
      cities.save
    end
    areas.save
  end
  countries.save
end
regions.save
