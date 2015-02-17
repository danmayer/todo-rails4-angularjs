class Api::TripDestinationsController < Api::BaseController
  before_action :check_owner, only: [:show, :update, :destroy]
  
  def index
    render json: trip.trip_destinations
  end

  def show
    render json: trip_destination
  end

  def create
    destination_params = safe_params
    destination_params[:arrival] = begin
                                     Time.parse(destination_params[:arrival])
                                   rescue
                                     Time.now
                                   end
    #TODO we need to pass destination_id not title
    destination_id = Destination.find_by(title: destination_params[:title]).try(:id)
    destination_params.delete(:title)
    destination_params[:destination_id] = destination_id
    trip_destination = trip.trip_destinations.create!(destination_params)
    render json: trip_destination
  end

  def update
    trip.update_attributes(safe_params)
    render nothing: true
  end

  def destroy
    trip.destroy
    render nothing: true
  end

  private
  def check_owner
    permission_denied if current_user != trip.owner
  end

  def trip
    @trip ||= current_user.trips.find(params[:trip_id])    
  end

  def trip_destination
    @trip_destination ||= trip.trip_destinations.find(params[:id])
  end

  def safe_params
    params.require(:tripDestination).permit(:title, :arrival)
  end
end
