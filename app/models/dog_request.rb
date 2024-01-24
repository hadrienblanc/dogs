class DogRequest < ApplicationRecord
  normalizes :breed, with: -> breed { breed.strip.downcase }

  validates :breed, presence: true
end
