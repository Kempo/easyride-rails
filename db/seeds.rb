# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tim = Rider.create!( 
  name: "Tim",
  address: "New York"
)

max = Rider.create!( 
  name: "Max",
  address: "Pike Place Market"
)

jacob = Driver.create!(
  name: "Jacob",
  address: "Seattle",
  total_space: 3
)

kevin = Driver.create!(
  name: "Kevin",
  address: "New Orleans",
  total_space: 3
)

# kevin: [max, tim]
Preference.create!(
  preferrer: kevin,
  preferable: max
)

Preference.create!(
  preferrer: kevin,
  preferable: tim
)

# jacob: [tim, max]
Preference.create!(
  preferrer: jacob,
  preferable: tim
)

Preference.create!(
  preferrer: jacob,
  preferable: max
)

# tim: [jacob, kevin]
Preference.create!(
  preferrer: tim,
  preferable: jacob
)

Preference.create!(
  preferrer: tim,
  preferable: kevin
)

# max: [kevin, jacob]
Preference.create!(
  preferrer: max,
  preferable: kevin
)

Preference.create!(
  preferrer: max,
  preferable: jacob
)


