# app/jobs/update_dog_request_job.rb

class UpdateDogRequestJob < ApplicationJob
  queue_as :default
  retry_on StandardError, wait: 5.seconds, attempts: 3


  def perform(dog_request_id)
    dog_request = DogRequest.find(dog_request_id)

    DogImageFetcher.new(dog_request).run

    Turbo::StreamsChannel.broadcast_replace_to(
      'dog_request_channel',
      partial: 'dog_requests/dog_request',
      target: "dog_request_#{dog_request.id}",
      locals: { dog_request: }
    )
  end
end
