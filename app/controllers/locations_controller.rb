class LocationsController < ApiController
  before_action :set_location, only: [:show, :update, :destroy]

  # get /locations
  def index
    @locations = Location.all
    json_response(@locations)
  end

  # post /locations
  def create
    @location = Location.create!(location_params)
    json_response(@location)
  end

  # get /locations/:id
  def show
    json_response(@location)
  end

  # put /locations/:id
  def update
    @location.update(location_params)
  end

  # delete /locations/:id
  def destroy
    @location.destroy
  end

  private

  def location_params
    params.permit(:name)
  end

  def set_location
    @location = Location.find(params[:id])
  end
end
