# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'net/http'
require "net/https"

user = User.first
trip = user.trips.first

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
      estimate: 100.00,
      quantity: 1
    },
    {
      title: "immunizations",
      notes: "You might need some immunizations, sometimes health insurance covers this.",
      estimate: 100.00,
      quantity: 1
    },
  ]
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

country_json = get_country_json

country_json.each do |destination|
  name = destination['name']['common']
  if Destination.where(title: name).any?
    Destination.where(title: name).first.destroy
  end
  destination_data = {
    title: name,
    default_options: destinations_defaults.to_json
  }
  Destination.create(destination_data)
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
