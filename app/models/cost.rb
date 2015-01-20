class Cost < ActiveRecord::Base
  belongs_to :trip
  belongs_to :trip_destinations
  
  def owner
    trip.owner
  end
  
  validates :trip, presence: true
  validates :title, presence: true
end
