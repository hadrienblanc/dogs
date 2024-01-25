require 'test_helper'

class DogRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dog_requests_url
    assert_response :success
  end

  test "should create dog_request and redirect to root" do
    assert_difference('DogRequest.count') do
      post dog_requests_url, params: { dog_request: { breed: 'Labrador' } }
    end
  
    assert_redirected_to root_url
    assert_enqueued_with(job: UpdateDogRequestJob)
  end
  
  test "should create dog_request with turbo_stream" do
    assert_difference('DogRequest.count') do
      post dog_requests_url, params: { dog_request: { breed: 'Labrador' } }, as: :turbo_stream
    end
  
    assert_response :success
    assert_enqueued_with(job: UpdateDogRequestJob)
  end
end
