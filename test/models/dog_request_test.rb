require 'test_helper'

class DogRequestTest < ActiveSupport::TestCase
  test 'breed should be present' do
    dog_request = DogRequest.new(breed: nil)
    assert_not dog_request.valid?
    assert_includes dog_request.errors[:breed], "can't be blank"
  end

  test 'breed is normalized to downcase and stripped' do
    dog_request = DogRequest.create(breed: ' Labrador Retriever ')
    assert_equal 'labrador retriever', dog_request.breed
  end
end
