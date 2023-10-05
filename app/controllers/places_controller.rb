class PlacesController < ApplicationController
  before_action :find_trip
  before_action :find_place, only: [:update, :destroy]

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

    response = HTTP.get("https://api.geoapify.com/v2/places?categories=#{category}&filter=circle:#{longitude},#{latitude},#{proximity}&bias=proximity:#{longitude},#{latitude}&limit=25&apiKey=#{Rails.application.credentials.geoapify_api_key}")
    render json: response.parse(:json)
  end

  def create
    @traveler = @trip.travelers.find_by(user_id: current_user.id)

    if @traveler.admin
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
    else
      render json: { error: "Must be admin to create place"}
    end
  end

  def update
    @traveler = @trip.travelers.find_by(user_id: current_user.id)

    if @traveler.admin
      @place.update(
        address: params[:address] || @place.address,
        name: params[:name] || @place.name,
        description: params[:description] || @place.description,
        image_url: params[:image_url] || @place.image_url,
        start_time: params[:start_time] || @place.start_time,
        end_time: params[:end_time] || @place.end_time
      )
      render :show
    else
      render json: { error: "Must be admin to update place"}
    end
  end

  def destroy
    @traveler = @trip.travelers.find_by(user_id: current_user.id)
    if @traveler.admin
      @place.destroy
      render json: {message: "Place deleted"}
    else
      render json: { error: "Must be admin to delete place"}
    end
  end

  private
    def find_trip
      @trip = Trip.find(params[:trip_id])
    end

    def find_place
      @place = @trip.places.find(params[:id])
    end
end
