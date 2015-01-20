class Destination < ActiveRecord::Base
  has_many :trip_destinations
  has_many :trips, through: :trip_destinations
  
  validates :title, presence: true
end
