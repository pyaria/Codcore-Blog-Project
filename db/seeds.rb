# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include ActionView::Helpers::TagHelper

100.times do
  parg = ""
  rand(2..8).times do
    parg += Faker::Lorem.paragraph(rand(7..19))
    parg += "\n\n"
  end
  Post.create({
    title: Faker::Company.catch_phrase,
    body: parg

    })
end
