class DogRequestChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'dog_request_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
