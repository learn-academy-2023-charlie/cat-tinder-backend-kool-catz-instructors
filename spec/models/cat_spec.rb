require 'rails_helper'

RSpec.describe Cat, type: :model do
  it 'should not be valid without a name' do
    cat = Cat.create(
      name:nil,
      age:3, 
      hobby:'king of the jungle', 
      image:'https://freesvg.org/img/OnlyWine-186.png'
    )
    expect(cat.errors[:name]).to_not be_empty
  end

  it 'should not be valid without an age' do
    cat = Cat.create(
      name:'Simba',
      age:nil, 
      hobby:'king of the jungle', 
      image:'https://freesvg.org/img/OnlyWine-186.png'
    )
    expect(cat.errors[:age]).to_not be_empty
  end

  it 'should not be valid without a hobby' do
    cat = Cat.create(
      name:'Simba',
      age:3, 
      hobby:nil, 
      image:'https://freesvg.org/img/OnlyWine-186.png'
    )
    expect(cat.errors[:hobby]).to_not be_empty
  end

  it 'should not be valid without an image' do
    cat = Cat.create(
      name:'Simba',
      age:3, 
      hobby:'plays with yarn', 
      image:nil
    )
    expect(cat.errors[:image]).to_not be_empty
  end

  it 'should not be valid with a hobby that has less than 10 characters' do
    cat = Cat.create(
      name:'Simba',
      age:3, 
      hobby:'knits', 
      image:'https://freesvg.org/img/OnlyWine-186.png'
    )
    expect(cat.errors[:hobby]).to_not be_empty
  end
  
end
