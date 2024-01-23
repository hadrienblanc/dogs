class DogRequest < ApplicationRecord
  validates :breed, presence: true
end
