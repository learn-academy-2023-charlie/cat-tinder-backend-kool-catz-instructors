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
  end

end
