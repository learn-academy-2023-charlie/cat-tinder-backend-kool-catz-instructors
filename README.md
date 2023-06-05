As a developer, I can add a resource for Cat that has a name, an age, what the cat enjoys doing, and an image.

rails g resource Cat name:string age:integer hobby:text image:text

Remember to migrate to update the schema

As a developer, I can add cat seeds to the `seeds.rb` file.

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

As a developer, I can run the rails command to add cats to database.

$ rails db:seed

rails routes
- http://localhost:3000/rails/info/routes
- $ rails routes -E

rails db:setup
- allows database to be created, migrated, and seeded