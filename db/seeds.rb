# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.all.length == 0
  admin = User.new
  admin.username = "Admin"
  admin.email = "admin@properties.com"
  admin.password = "propertyKing"
  admin.password_confirmation = "propertyKing"
  admin.admin = true
  admin.save

  user = User.new
  user.username = "propertyBro"
  user.email = "user@properties.com"
  user.password = "propertyBro"
  user.password_confirmation = "propertyBro"
  user.save
end
