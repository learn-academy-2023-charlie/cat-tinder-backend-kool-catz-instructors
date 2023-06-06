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

  describe "POST /create" do
    it 'creates a cat' do
      cat_params = {
        cat: {
          name:'Garfield', 
          age:6, 
          hobby:'eating lasagna', 
          image:'https://freesvg.org/img/OnlyWine-186.png'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq 'Garfield'
      expect(cat.age).to eq 6
      expect(cat.hobby).to eq 'eating lasagna'
    end

    # validates that a cat will not be created if missing an attribute
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
      expect(cat_json['name']).to include "can't be blank"
    end

    it 'will not create a cat that is missing an age' do
      # attributes
      cat_params = {
        cat: {
          name:'Henri', 
          age:nil, 
          hobby:'eating lasagna', 
          image:'https://freesvg.org/img/OnlyWine-186.png'
        }
      }
      # request
      post '/cats', params: cat_params
      # assertion on the response
      # status
      p "create response", response.status
      expect(response.status).to eq(422)
      # payload
      cat_json = JSON.parse(response.body)
      # p "json hash", cat_json
      expect(cat_json['age']).to include "can't be blank"
    end

    it 'will not create a cat that is missing an image' do
      # attributes
      cat_params = {
        cat: {
          name:'Henri', 
          age:2, 
          hobby:'eating lasagna', 
          image:nil
        }
      }
      # request
      post '/cats', params: cat_params
      # assertion on the response
      # status
      p "create response", response.status
      expect(response.status).to eq(422)
      # payload
      cat_json = JSON.parse(response.body)
      # p "json hash", cat_json
      expect(cat_json['image']).to include "can't be blank"
    end

  end

end
