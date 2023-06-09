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

## As a developer, I can add the appropriate model specs that will ensure an incomplete cat throws an error.
- Write the test in spec/models/cat_spec.rb
```rb
  it 'should not be valid without a name' do
    cat = Cat.create(
      name:nil,
      age:3, 
      hobby:'king of the jungle', 
      image:'https://freesvg.org/img/OnlyWine-186.png'
    )
    expect(cat.errors[:name]).to_not be_empty
  end
```  
- See it fail: $ `rspec spec/models/cat_spec.rb`

## As a developer, I can add the appropriate model validations to ensure the user submits a name, an age, what the cat enjoys, and an image.
- Write the code in app/models/cat.rb
```rb
  validates :name, presence: true
```
- See it pass: $ `rspec spec/models/cat_spec.rb`

## As a developer, I can add the appropriate model specs that will ensure a cat enjoys entry is at least 10 characters long.
- Write the test in spec/models/cat_spec.rb
```rb
  it 'should not be valid with a hobby that has less than 10 characters' do
    cat = Cat.create(
      name:'Simba',
      age:3, 
      hobby:'knits', 
      image:'https://freesvg.org/img/OnlyWine-186.png'
    )
    expect(cat.errors[:hobby]).to_not be_empty
  end
```  
- See it fail: $ `rspec spec/models/cat_spec.rb`

## As a developer, I can add a validation to assure that will ensure a cat enjoys entry is at least 10 characters long.
- Write the code in app/models/cat.rb
```rb
  validates :name, :hobby, presence: true
  validates :hobby, length: {minimum: 10}
```
- See it pass: $ `rspec spec/models/cat_spec.rb`

## As a developer, I can add the appropriate request validations to ensure the API is sending useful information to the frontend developer if a new cat is not valid.
- Write the test in spec/requests/cats_spec.rb
```rb
  it 'will not create a cat that is missing a name' do
    # attributes
    cat_params = {
      cat: {
        name:nil, 
        age:6, 
        hobby:'eating lasagna', 
        image:'https://freesvg.org/img/OnlyWine-186.png'
      }
    }
    # request
    post '/cats', params: cat_params
    # assertion on the response
    # status
    p 'create response', response.status
    expect(response.status).to eq(422)
    # payload
    cat_json = JSON.parse(response.body)
    p 'json hash', cat_json
    expect(cat_json['name']).to include "can't be blank"
  end
```  
- See it fail: $ `rspec spec/requests/cats_spec.rb`
***NOTE: using developer tool `p` to print data obtain from the status code from the response and error message from the json***
```bash
  Cats
    GET /index
      gets a list of cats
    POST /create
      creates a cat
  "create response"
  422
  "json hash"
  {"name"=>["can't be blank"]}
      will not create a cat that is missing a name (FAILED - 1)
```

## As a developer, I can add the appropriate request spec that will look for a 422 error if the create validations are not met.
- Write the code in app/controllers/cats_controller.rb
```rb
  def create
    cat = Cat.create(cat_params)
    if cat.valid?
      render json: cat
    else
      render json: cat.errors, status: 422
    end
  end
```
- See it pass: $ `rspec spec/requests/cats_spec.rb`
