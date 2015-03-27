class TripSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :trip_destinations, :costs, :unassociated_costs
end
