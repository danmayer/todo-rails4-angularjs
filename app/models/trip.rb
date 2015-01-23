class Trip < ActiveRecord::Base
  belongs_to :owner, class_name: User
  has_many :costs, -> { order :priority }, foreign_key: :trip_id, dependent: :destroy
  has_many :unassociated_costs, -> { where trip_destinations_id: nil }, :foreign_key => 'trip_id', :class_name => "Cost"
  has_many :trip_destinations
  has_many :destinations, through: :trip_destinations
  
  validates :owner, presence: true
  validates :title, presence: true
end
