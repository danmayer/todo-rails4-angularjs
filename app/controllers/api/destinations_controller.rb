class Api::DestinationsController < Api::BaseController

  def index
    render json: Destination.all
  end

  def show
    render json: destination
  end


  private

  def destination
    @destination ||= Destination.find(params[:id])    
  end

end
