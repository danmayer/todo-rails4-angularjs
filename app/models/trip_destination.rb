class TripDestination < ActiveRecord::Base
  belongs_to :trip
  belongs_to :destination
  has_many :costs, -> { order :priority }, foreign_key: :trip_destinations_id, dependent: :destroy

  after_create :create_default_costs
  
  def title
    destination.try(:title)
  end

  private
  
  def create_default_costs
    #TODO calculate flight cost from previous country to this new destination
    initial_costs = destination.default_options['costs']
    initial_costs.each do |cost|
      cost.merge!(trip_destinations_id: self.id)
    end
    initial_costs << {
      title: "daily spending money",
      notes: "Daily spend (food, drinks, tourist sites, souvenirs, and local transport)",
      estimate: destination.default_options['cost_per_day'],
      quantity: self.days,
      trip_destinations_id: self.id
    }
    trip.costs.create(initial_costs)
    self.save
  end
  
end
