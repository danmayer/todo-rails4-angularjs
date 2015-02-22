class TripDestinationSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :destination_id, :notes, :arrival, :title, :days
  has_many :costs
end
