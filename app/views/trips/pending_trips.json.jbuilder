json.array!(@pending_trips) do |trip|
  json.id trip.id
  json.user_id trip.user_id
  json.user_name trip.user.name
  json.title trip.title
  json.image_url trip.image_url
  json.start_time trip.start_time.strftime("%B %e, %Y")
  json.end_time trip.end_time.strftime("%B %e, %Y")
end
