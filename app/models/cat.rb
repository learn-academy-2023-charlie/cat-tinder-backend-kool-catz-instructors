class Cat < ApplicationRecord
  validates :name, :age, :hobby, :image, presence: true
  validates :hobby, length: {minimum: 10}
end
