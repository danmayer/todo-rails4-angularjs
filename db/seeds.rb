# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.first
trip = user.trips.first

if Destination.count == 0
  Destination.create([{title: 'Chicago'}, {title: 'Japan'}, {title: 'Asia'}, {title: 'Vietnam'}])
end

if user.trips.length == 0
  trip ||= user.trips.create(title: 'SE Asia', begin_date: 2.weeks.ago)
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
    {destination_id: Destination.find_by(title: 'Asia').id, notes: 'not so much a destination', arrival: 1.days.ago}
  ])
end