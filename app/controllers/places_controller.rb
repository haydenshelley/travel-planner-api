class PlacesController < ApplicationController
  def index
    @places = Place.all
    render :index
  end

  def show
    @place = Place.find_by(id: params[:id])
  end

  def recommendations
    location = params[:location]

    location_response = HTTP.get("https://api.geoapify.com/v1/geocode/search?text=#{location}&apiKey=#{Rails.application.credentials.geoapify_api_key}")

    # binding.pry
    # render json: location_response.parse(:json)

    longitude = location_response.parse(:json)["features"][0]["properties"]["lon"]
    latitude = location_response.parse(:json)["features"][0]["properties"]["lat"]
    proximity = params[:proximity]
    category = params[:category]

    response = HTTP.get("https://api.geoapify.com/v2/places?categories=#{category}&filter=circle:#{longitude},#{latitude},#{proximity}&bias=proximity:#{longitude},#{latitude}&limit=50&apiKey=#{Rails.application.credentials.geoapify_api_key}")
    render json: response.parse(:json)
  end

  def create
    @place = Place.create(
      trip_id: params[:trip_id],
      address: params[:address],
      name: params[:name],
      description: params[:description],
      image_url: params[:image_url],
      start_time: params[:start_time],
      end_time: params[:end_time]
    )
    render :show
  end

  def update
    @place = Place.find_by(id: params[:id])
    @place.update(
      address: params[:address] || @place.address,
      name: params[:name] || @place.name,
      description: params[:description] || @place.description,
      image_url: params[:image_url] || @place.image_url,
      start_time: params[:start_time] || @place.start_time,
      end_time: params[:end_time] || @place.end_time
    )
    render :show
  end

  def destroy
    @place = Place.find_by(id:params[:id])
    @place.destroy
    render json: {message: "Place deleted"}
  end
end
