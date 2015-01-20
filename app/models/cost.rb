class Cost < ActiveRecord::Base
  belongs_to :trip

  def owner
    trip.owner
  end
  
  validates :trip, presence: true
  validates :title, presence: true
end
