# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ffaker'

Skill.destroy_all
Developer.destroy_all

skills = []
50.times do
  skills << FFaker::Skill.tech_skill
end

skills.uniq!

skills.each do |skill|
  Skill.create({name:skill})
end
