## rails commands and informational sites
- rails routes
  - http://localhost:3000/rails/info/routes
  - $ `rails routes -E`

- $ `rails db:drop`
  - to drop the database

- $ `rails db:setup`
  - allows database to be created, migrated, and seeded
  - replaces the following commands:
    - $  `rails db:create`
    - $  `rails db:migrate`
    - $  `rails db:seed`

## branch: main
- Create empty repo from the Cat Tinder Project link
- Create an API
  - $  `rails new cat_tinder_backend -d postgresql -T`
  - $  `cd cat_tinder_backend`
  - $  `rails db:create`
  - $  `bundle add rspec-rails`
  - $  `rails generate rspec:install`
  - $  `<git remote add origin command from the empty github repo for your team>`
  - $  `git checkout -b main`
  - $  `git status`
  - $  `git add .`
  - $  `git commit -m "initial commit"`
  - $  `git push origin main`
- Create a request to add branch protection on slack thread

## branch: backend-structure
## As a developer, I can add a resource for Cat that has a name, an age, what the cat enjoys doing, and an image.
- $ `rails g resource Cat name:string age:integer hobby:text image:text`  
Remember to migrate to update the schema
- $ `rails db:migrate`

## As a developer, I can add cat seeds to the `seeds.rb` file.
```rb
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
```

## As a developer, I can run the rails command to add cats to database.
- $ `rails db:seed`

