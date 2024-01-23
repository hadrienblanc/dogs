// app/javascript/channels/dog_request_channel.js
import consumer from "./consumer"
import { Turbo } from "@hotwired/turbo-rails"

consumer.subscriptions.create("DogRequestChannel" , {
  connected() {
  },

  received(data) {
    Turbo.renderStreamMessage(data)
  }
})
