class Api::CostsController < Api::BaseController
  before_action :check_owner, only: [:show, :update, :destroy]

  def index
    render json: trip.costs
  end

  def show
    render json: cost
  end

  def create
    new_cost = trip.costs.create!(safe_params)
    render json: new_cost
  end

  def update
    cost.update_attributes(safe_params)
    render nothing: true
  end

  def destroy
    cost.destroy
    render nothing: true
  end

  private
  def check_owner
    permission_denied if current_user != trip.owner
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
  end
  
  def cost
     @cost ||= trip.costs.find(params[:id])
  end

  def safe_params
    params.require(:cost).permit(:title, :notes, :estimate)
  end
end
