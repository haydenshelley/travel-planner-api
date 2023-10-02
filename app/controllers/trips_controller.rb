class TripsController < ApplicationController
  def index
    @trips = Trip.where(user_id: current_user.id)
    render :index
  end

  def show
    @trip = Trip.find_by(id: params[:id])
    render :show
  end

  def create
    @trip = Trip.create(
      user_id: current_user.id,
      title: params[:title],
      image_url: params[:image_url],
      start_time: params[:start_time],
      end_time: params[:end_time]
    )
    render :show
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    @trip.destroy
    render json: {message: "Trip deleted"}
  end
end
