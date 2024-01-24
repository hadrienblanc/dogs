require 'test_helper'

class DogImageFetcherTest < ActiveSupport::TestCase
  include WebMock::API

  def setup
    @dog_request = create(:dog_request, breed: 'labrador')
    @fetcher = DogImageFetcher.new(@dog_request)
    stub_request(:any, /dog.ceo/).to_return(body: { message: "http://example.com/dog.jpg" }.to_json, status: 200)
  end

  test "run successfully updates dog_request with image url" do
    @fetcher.run
    assert_equal "http://example.com/dog.jpg", @dog_request.url
    assert_not_nil @dog_request.responded_at
  end

  test "fetch_random_image handles invalid URL" do
    stub_request(:any, /dog.ceo/).to_return(body: { message: "bad breed name" }.to_json, status: 200)
    @fetcher.run
    assert_equal "bad breed name", @dog_request.reload.error_message
    assert_not_nil @dog_request.responded_at
  end


  test "get handles exceptions" do
    stub_request(:any, /dog.ceo/).to_raise(StandardError.new("Network error"))
    @fetcher.run
    assert_equal "Network error", @dog_request.error_message
  end

  test "valid_url? returns true for valid URLs" do
    assert @fetcher.valid_url?("http://example.com/dog.jpg")
  end

  test "valid_url? returns false for invalid URLs" do
    refute @fetcher.valid_url?("invalid_url")
  end

  test "uri contains correct breed" do
    assert_equal "https://dog.ceo/api/breed/labrador/images/random", @fetcher.send(:uri).to_s
  end
end
