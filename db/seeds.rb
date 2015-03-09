# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'net/http'
require "net/https"
require 'csv'

user = User.first
trip = user.trips.first

DEFAULT_VISA_COST = 100.00
destinations_defaults = {
  costs: [
    {
      title: "flight",
      notes: "The cost to fly to this country from your previous country",
      estimate: 800.00,
      quantity: 1
    },
    {
      title: "Visa",
      notes: "You might need to get a Visa to visit this country",
      estimate: DEFAULT_VISA_COST,
      quantity: 1
    },
    {
      title: "immunizations",
      notes: "You might need some immunizations, sometimes health insurance covers this.",
      estimate: 100.00,
      quantity: 1
    }
  ],
  cost_per_day: 45.00,
  hotel_per_night: 30.00
}

def get_country_json
  url = 'https://raw.githubusercontent.com/mledoze/countries/master/countries.json'
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  
  request = Net::HTTP::Get.new(uri.request_uri)
  
  response = http.request(request)
  JSON.parse(response.body)
end

###
# This mostly works but not all the airport codes match to Kayak how to ensure that
###
def load_airport_data
  return @csv_data if @csv_data

  @csv_data = {}
  airport_data = File.read(Rails.root.join('db/migrate/airports.dat'))
  CSV.new(airport_data).each do |row|
    #country_name => airport code
    if @csv_data[row[3]].nil?
      @csv_data[row[3]] = row[4]
    end
  end
  @csv_data
end

country_json = get_country_json
aiport_data = load_airport_data
visas = Visa.new

country_json.each do |destination|
  name = destination['name']['common']
  airport_code = nil
  country_defaults = destinations_defaults
  
  if aiport_data[name]
    airport_code = aiport_data[name]
  end

  if Destination.where(title: name).first.try(:estimated_visa_cost)==DEFAULT_VISA_COST
    if visa_cost = visas.cost_for_country(name.downcase)
      country_defaults[:costs].select{|c| c[:title].match(/visa/i) }.first[:estimate] = visa_cost
    end
    sleep(2)
  end
  
  destination_data = {
    title: name,
    airport_code: airport_code,
    default_options: country_defaults
  }
  if Destination.where(title: name).any?
    Destination.where(title: name).first.update(destination_data)
  else
    Destination.create(destination_data)
  end
end

if user.trips.length == 0
  trip ||= user.trips.create(title: 'SE Asia', begin_date: 2.weeks.from_now)
end

if trip.costs.length == 0
trip.costs.create([
  {title: 'visa', estimate: 100.00, notes: 'rush fee included', quantity: 2},
  {title: 'flight', estimate: 700.00, notes: 'round trip', quantity: 2},
  {title: 'hotel', estimate: 400.00, notes: 'by airport', quantity: 1},
  ])
end

if trip.trip_destinations.length == 0
  trip.trip_destinations.create([
    {destination_id: Destination.find_by(title: 'Vietnam').id, notes: 'the best', arrival: 2.days.ago},
    {destination_id: Destination.find_by(title: 'Aruba').id, notes: 'honeymoon!', arrival: 1.days.ago}
  ])
end
