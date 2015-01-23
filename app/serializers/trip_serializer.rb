class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :costs, :unassociated_costs
  has_many :trip_destinations
end