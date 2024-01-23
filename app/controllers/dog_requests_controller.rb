class DogRequestsController < ApplicationController
  def index
    @dog_requests = DogRequest.order(created_at: :desc)
    @dog_request = DogRequest.new
  end

  def create
    @dog_request = DogRequest.create(dog_request_params)
    UpdateDogRequestJob.perform_later(@dog_request.id)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def update
    @dog_request = DogRequest.find(params[:id])
    # Fetch from API and update @dog_request
    @dog_request.update(url: 'todo.com', responded_at: DateTime.now)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def dog_request_params
    params.require(:dog_request).permit(:breed)
  end
end
