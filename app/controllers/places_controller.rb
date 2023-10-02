class PlacesController < ApplicationController
  def index
    @places = Place.all
    render :index
  end

  def show
    @place = Place.find_by(id: params[:id])
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
