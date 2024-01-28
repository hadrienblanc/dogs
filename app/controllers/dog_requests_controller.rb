class DogRequestsController < ApplicationController
  MAX_DOGS_ON_INDEX = 100

  def index
    @dog_requests = DogRequest.order(created_at: :desc).limit(MAX_DOGS_ON_INDEX)
  end

  def create
    @dog_request = DogRequest.create(dog_request_params)
    UpdateDogRequestJob.perform_later(@dog_request.id)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def dog_request_params
    params.require(:dog_request).permit(:breed)
  end
end
