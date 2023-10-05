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

    @traveler = Traveler.create(
      user_id: current_user.id,
      trip_id: @trip.id,
      admin: true,
      accepted: true
    )

    render :show
  end

  def update
    @trip = Trip.find_by(id: params[:id])
    @traveler = @trip.travelers.find_by(user_id: current_user.id)
    if @traveler&.admin?
      @trip.update(
        title: params[:title] || @trip.title,
        image_url: params[:image_url] || @trip.image_url,
        start_time: params[:start_time] || @trip.start_time,
        end_time: params[:end_time] || @trip.end_time
      )
      render :show
    elsif @traveler.nil?
      render json: { error: "User not added to this trip"}
    elsif @traveler && !@traveler.admin
      render json: { error: "User not admin on this trip"}
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])
    @traveler = @trip.travelers.find_by(user_id: current_user.id)
    if @traveler&.admin?
      @trip.destroy
      render json: {message: "Trip deleted"}
    elsif @traveler.nil?
      render json: { error: "User not added to this trip"}
    elsif @traveler && !@traveler.admin
      render json: { error: "User not admin on this trip"}
    end
  end
end
