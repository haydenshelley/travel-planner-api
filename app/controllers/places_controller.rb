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
end
