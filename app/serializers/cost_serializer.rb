class CostSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :title, :notes, :estimate, :quantity, :final_total, :priority, :paid, :trip_destinations_id
end