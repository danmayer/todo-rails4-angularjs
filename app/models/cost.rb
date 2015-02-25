class Cost < ActiveRecord::Base
  belongs_to :trip
  belongs_to :trip_destinations
  
  validates :trip, presence: true
  validates :title, presence: true
  
  def owner
    trip.owner
  end

  private
  
end
