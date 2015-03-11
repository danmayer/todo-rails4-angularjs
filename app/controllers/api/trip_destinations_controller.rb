begin
  require 'Date'
rescue
  #don't care that this fails in asset compilation debug later
end
  
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
    destination_params[:arrival] = parsed_arrival
    destination_title = destination_params.delete(:title)
    if (destination_params[:destination_id])==nil
      destination_id = Destination.where(:title => destination_title.try(:capitalize)).try(:first).try(:id)
      destination_params[:destination_id] = destination_id if destination_id
    end
    trip_destination = trip.trip_destinations.create!(destination_params)
    render json: trip_destination
  end

  def update
    trip_destination.update_attributes(safe_params)
    render nothing: true
  end

  def destroy
    trip_destination.destroy
    render nothing: true
  end

  private
  def parsed_arrival
    begin
      Date.strptime(safe_params[:arrival], "%m/%d/%Y")
    rescue => e
      Rails.logger.info("error parsing date: #{safe_params[:arrival]}")
      Time.now
    end
  end
  
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
    params.require(:tripDestination).permit(:destination_id, :arrival, :days, :title)
  end
end
