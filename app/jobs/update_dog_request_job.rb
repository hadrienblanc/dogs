# app/jobs/update_dog_request_job.rb

class UpdateDogRequestJob < ApplicationJob
  queue_as :default

  def perform(dog_request_id)
    dog_request = DogRequest.find(dog_request_id)

    sleep 1
    dog_request.update(url: 'new_url after 4 second sleep')

    Turbo::StreamsChannel.broadcast_replace_to(
      'dog_request_channel',
      partial: 'dog_requests/dog_request',
      target: "dog_request_#{dog_request.id}",
      locals: { dog_request: }
    )
  end
end
