# TODO becoming obvious I need some cost subclasses 
class Cost < ActiveRecord::Base
  belongs_to :trip
  belongs_to :trip_destination, foreign_key: :trip_destinations_id
  
  validates :trip, presence: true
  validates :title, presence: true

  DEFAULT_AIRPORT = 'JFK' 
  
  def owner
    trip.owner
  end

  def source_link
    if title.match(/flight/i)
      "http://www.kayak.com/flights/#{from_aiport}-#{to_airport}/#{arrival_date}/#{departure_date}"
    elsif title.match(/visa/i)
      if trip_destination
        Visa.country_url(trip_destination.title.downcase)
      end
    elsif title.match(/travel insurance/i)
      "http://www.worldnomads.com/"
    end
  end

  def source_title
    if title.match(/flight/)
      "flight prices"
    elsif title.match(/visa/i)
      if trip_destination
        "visa price"
      end
    elsif title.match(/travel insurance/i)
      "insurance price"
    end
  end

  private
  
  def from_aiport
    if trip_destination
      if trip.trip_destinations.length < 2
        DEFAULT_AIRPORT
      else
        current_destination_index = -1
        sorted_destinations.each_with_index do |dest, i|
          if dest.id == trip_destination.id
            return sorted_destinations[(i-1)].destination.airport_code
          end
        end
      end
    else
      DEFAULT_AIRPORT
    end
  end

  def to_airport
    if trip_destination
      trip_destination.destination.airport_code
    else
      'JFK'
    end
  end

  def sorted_destinations
    @sorted_destinations ||= trip.trip_destinations.sort{|a,b| a.arrival <=> b.arrival }
  end
  
  def arrival_date
    date = if trip_destination && trip_destination.arrival > 1.day.from_now
             trip_destination.arrival
           else
             1.weeks.from_now
           end
    date.strftime("%Y-%m-%d")
  end

  def departure_date
    date = if trip_destination && trip_destination.arrival > 1.day.from_now
             trip_destination.arrival+(trip_destination.days).days
           else
             2.weeks.from_now
           end
    date.strftime("%Y-%m-%d")
  end
    
end
