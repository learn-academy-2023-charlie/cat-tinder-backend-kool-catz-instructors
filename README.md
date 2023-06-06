# Cat Tinder Project (Backend) - 6/5/23 Charlie

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

- review
 [2023 Charlie How The Internet Works.pdf](https://github.com/learn-academy-2023-charlie/cat-tinder-backend-kool-catz-instructors/files/11661538/2023.Charlie.How.The.Internet.Works.pdf)

***
## switching drivers
***NOTE: Perform after all steps for main branch are completed by first driver***
- join the team on the cat tinder project link
- clone the repo
- load all dependencies: $ `bundle`
- $ `rails db:setup`
***
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
***
## branch: backend-structure
### As a developer, I can create a RSpec testing suite in my Rails application.
- performed by installing rspec-rails gem and generating rspec

### As a developer, I can add a resource for Cat that has a name, an age, what the cat enjoys doing, and an image.
- $ `rails g resource Cat name:string age:integer hobby:text image:text`  
Remember to migrate to update the schema
- $ `rails db:migrate`

### As a developer, I can add cat seeds to the `seeds.rb` file.
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

### As a developer, I can run the rails command to add cats to database.
- $ `rails db:seed`

### As a developer, I can enable my controller to accept requests from outside applications.
```ruby
  # disable the authenticity token in app/controllers/application_controller.rb
  class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
  end
```

### As a developer, I can add the CORS gem to my Rails application.
- Two options 
  1. modify Gemfile by adding `gem 'rack-cors', :require => 'rack/cors'`
  2. add rack-cors gem through the terminal: 
    - $ `bundle add rack-cors`
    - Check that `gem "rack-cors"` was installed at the end of the Gemfile

### As a developer, I can add the `cors.rb` file to my application.
- Create file called `cors.rb` in config/initializers
- Add the following lines of code to the file
```rb
  # Avoid CORS issues when API is called from the frontend app.
  # Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

  # Read more: https://github.com/cyu/rack-cors

  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # <- change this to allow requests from any domain while in development.

      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
```
- Update the dependencies: $ `bundle`
- Create a pull request review
***
-----
## branch: api-endpoints
## As a developer, I can add an index request spec to my application.
```rb
  require 'rails_helper'

  RSpec.describe "Cats", type: :request do
    describe "GET /index" do
      it 'gets a list of cats' do
        Cat.create(
          name:'Garfield', 
          age:6, 
          hobby:'eating lasagna', 
          image:'https://freesvg.org/img/OnlyWine-186.png'
        )
        get '/cats'
        cat = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(cat.length).to eq 1
      end
    end
  end
```

## As a developer, I can add an index endpoint to my application.
```rb
  class CatsController < ApplicationController

    def index
      cats = Cat.all
      render json: cats
    end
  end
```
***
## API Validations
- ensures the data is clean: it contains all the required attributes
- test the app/models through spec/models
- test the app/controllers through spec/requests

- Think about what you want to do
- Think about how you will test it

- TDD
  - Write the test
  - See it fail
  - Write the code
  - See it pass

```bash
  Cats
  GET /index
    gets a list of cats
  POST /create
    creates a cat
"create response"
422
    will not create a cat that is missing a name
"create response"
422
"json hash"
{"age"=>["can't be blank"]}
    will not create a cat that is missing an age (FAILED - 1)

Failures:

  1) Cats POST /create will not create a cat that is missing an age
     Failure/Error: expect(cat_json['name']).to include "can't be blank"
       expected nil to include "can't be blank", but it does not respond to `include?`
     # ./spec/requests/cats_spec.rb:79:in `block (3 levels) in <top (required)>'

Finished in 0.0771 seconds (files took 1.08 seconds to load)
4 examples, 1 failure

Failed examples:

rspec ./spec/requests/cats_spec.rb:60 # Cats POST /create will not create a cat that is missing an age

```