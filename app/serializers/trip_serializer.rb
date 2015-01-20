class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :costs
  has_many :trip_destinations
end