class Trip < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :costs, -> { order :priority }, foreign_key: :trip_id, dependent: :destroy
  has_many :unassociated_costs, -> { where trip_destinations_id: nil }, :foreign_key => 'trip_id', :class_name => "Cost"
  has_many :trip_destinations
  has_many :destinations, through: :trip_destinations

  serialize :default_options, JSON
  
  validates :owner, presence: true
  validates :title, presence: true

  before_create :set_default_options
  after_create :create_default_costs
  
  private

  def set_default_options
    self.default_options = {
      costs: [
        {
          title: "luggage",
          notes: "You might need new luggage (bag, daypack)",
          estimate: 250.00,
          quantity: 1
        },
        {
          title: "travel clothes",
          notes: "You might need new clothes (coats, swimsuits, travel socks)",
          estimate: 300.00,
          quantity: 1
        },
        {
          title: "travel gear",
          notes: "You might need new gear (USB batter, kindle, tablet, camera)",
          estimate: 300.00,
          quantity: 1
        },
        {
          title: "travel insurance",
          notes: "You might want travel insurance",
          estimate: 350.00,
          quantity: 1
        }
      ]
    }
  end

  def create_default_costs
    initial_costs = self.default_options['costs']
    self.costs.create(initial_costs)
    self.save
  end
  
end
