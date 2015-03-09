class Destination < ActiveRecord::Base
  has_many :trip_destinations
  has_many :trips, through: :trip_destinations

  serialize :default_options, JSON
  
  validates :title, presence: true

  def estimated_visa_cost
    default_options['costs'].select{|c| c['title'].match(/visa/i)}.first['estimate']
  end
end
