json.id place.id
json.trip_id place.trip_id
json.address place.address
json.name place.name
json.description place.description
json.image_url place.image_url
json.date place.start_time.strftime("%B %e, %Y")
json.start_time place.start_time.strftime("%D")
json.end_time place.end_time.strftime("%D")
json.start place.start_time.strftime("%r")
json.end place.end_time.strftime("%r")
