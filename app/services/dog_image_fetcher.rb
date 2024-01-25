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

    if valid_url?(parsed_response['message']) 
      @dog_request.update!(url: parsed_response['message'], responded_at: DateTime.now)
    else
      @dog_request.update!(error_message: parsed_response['message'], responded_at: DateTime.now)
    end
  end

  def get
    response = Net::HTTP.get_response(uri)
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      { 'message' => "Unable to fetch image", status: response.code }
    end
  rescue StandardError => e
    { 'message' => e.message }
  end

  def valid_url?(url)
    url.start_with?("http") && url =~ URI::DEFAULT_PARSER.make_regexp
  end

  def uri
    breed = CGI.escape(@dog_request.breed)
    URI("https://dog.ceo/api/breed/#{breed}/images/random")
  end
end
