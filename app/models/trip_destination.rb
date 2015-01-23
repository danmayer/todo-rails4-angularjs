class TripDestination < ActiveRecord::Base
  belongs_to :trip
  belongs_to :destination
  has_many :costs, -> { order :priority }, foreign_key: :trip_destinations_id, dependent: :destroy
  
  def title
    destination.title
  end
end