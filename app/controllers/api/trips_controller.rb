class Api::TripsController < Api::BaseController
  before_action :check_owner, only: [:show, :update, :destroy]

  def index
    render json: current_user.trips
  end

  def show
    render json: trip
  end

  def create
    trip = current_user.trips.create!(safe_params)
    render json: trip
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
    @trip ||= Trip.find(params[:id])    
  end

  def safe_params
    params.require(:trip).permit(:title)
  end
end
