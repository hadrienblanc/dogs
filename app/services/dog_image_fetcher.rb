require 'net/http'
require 'uri'
require 'json'
require 'cgi'

class DogImageFetcher
  def initialize(dog_request)
    @dog_request = dog_request
  end

  def run
    response = fetch_random_image
    update_dog_request(response)
  end

  def fetch_random_image
    response = Net::HTTP.get_response(uri)
    parse_response(response)
  rescue StandardError => e
    { 'message' => e.message }
  end

  def parse_response(response)
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      { 'message' => "Unable to fetch image", 'status' => response.code }
    end
  end

  def update_dog_request(response)
    if valid_url?(response['message'])
      @dog_request.update!(url: response['message'], responded_at: Time.current)
    else
      @dog_request.update!(error_message: response['message'], responded_at: Time.current)
    end
  end

  def valid_url?(url)
    url.start_with?("http") && url =~ URI::DEFAULT_PARSER.make_regexp
  end

  def uri
    breed = CGI.escape(@dog_request.breed)
    URI("https://dog.ceo/api/breed/#{breed}/images/random")
  end
end
