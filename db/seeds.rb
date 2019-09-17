# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "User1", password: "test")
User.create(name: "User2", password: "test")
User.create(name: "User3", password: "test")

Restaurant.create(name: "Spice Room", phone: "999-999-9999")
Restaurant.create(name: "Avanti", phone: "999-999-9999")
Restaurant.create(name: "Marcellas", phone: "999-999-9999")
Restaurant.create(name: "iFish", phone: "999-999-9999")
Restaurant.create(name: "Senor Bear", phone: "999-999-9999")
Restaurant.create(name: "Linger", phone: "999-999-9999")
Restaurant.create(name: "The Bindery", phone: "999-999-9999")

Experience.create(user_id: 1, restaurant_id: 1, rating: 4.5)
Experience.create(user_id: 2, restaurant_id: 1, rating: 5.7)
Experience.create(user_id: 3, restaurant_id: 1, rating: 3.9)
Experience.create(user_id: 1, restaurant_id: 2, rating: 9.5)
Experience.create(user_id: 2, restaurant_id: 2, rating: 8.7)
Experience.create(user_id: 3, restaurant_id: 3, rating: 7.8)
Experience.create(user_id: 1, restaurant_id: 3, rating: 8.7)
Experience.create(user_id: 1, restaurant_id: 4, rating: 10.0)
Experience.create(user_id: 2, restaurant_id: 4, rating: 8.5)
Experience.create(user_id: 2, restaurant_id: 4, rating: 9.1)
Experience.create(user_id: 2, restaurant_id: 5, rating: 1.1)
Experience.create(user_id: 3, restaurant_id: 5, rating: 2.1)
Experience.create(user_id: 2, restaurant_id: 6, rating: 9.1)
Experience.create(user_id: 2, restaurant_id: 7, rating: 8.1)
Experience.create(user_id: 1, restaurant_id: 7, rating: 3.1)
