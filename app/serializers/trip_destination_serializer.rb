class TripDestinationSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :destination_id, :notes, :arrival, :title
end