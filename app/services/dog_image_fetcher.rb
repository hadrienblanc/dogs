require 'net/http'

require 'net/http'
require 'uri'
require 'json'

class DogImageFetcher
  def initialize(dog_request)
    @dog_request = dog_request
  end

  def run
    fetch_random_image
  end

  def fetch_random_image
    parsed_response = get

    @dog_request.update!(url: parsed_response['message'], responded_at: DateTime.now)
  end

  def get
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      { error: "Unable to fetch image", status: response.code }
    end
  rescue StandardError => e
    { error: e.message }
  end

  def uri
    URI("https://dog.ceo/api/breed/#{@dog_request.breed}/images/random")
  end
end
