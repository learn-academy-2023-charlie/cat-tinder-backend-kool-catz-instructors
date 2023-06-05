# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
cats = [
  {
    name:'Garfield', 
    age:6, 
    hobby:'eating lasagna', 
    image:'https://freesvg.org/img/OnlyWine-186.png'
  },
  {
    name:'Slyvester', 
    age:10, 
    hobby:'chasing Tweety Bird', 
    image:'https://freesvg.org/img/OnlyWine-186.png'
  },
  {
    name:'Simba', 
    age:3, 
    hobby:'king of the jungle', 
    image:'https://freesvg.org/img/OnlyWine-186.png'
  }
]

cats.each do |attributes|
  Cat.create attributes
  p "created cat #{attributes}" 
end