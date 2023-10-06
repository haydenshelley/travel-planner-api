json.id traveler.id
json.trip traveler.trip
json.places traveler.trip.places.map do |place|
  json.partial! 'places/place', place: place
end
