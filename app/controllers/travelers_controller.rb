class TravelersController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    @traveler = @trip.travelers.create(
      user_id: params[:user_id],
      admin: false,
      accepted: false
    )

    render json: {message: "Traveler Created"}
  end

  def update
    @trip = Trip.find(params[:trip_id])
    @traveler = @trip.travelers.find(params[:id])
    @traveler.update(
      admin: params[:admin] || @traveler.admin,
      accepted: params[:accepted] || @traveler.accepted
    )

    render json: {message: "Traveler Updated"}
  end

  def destroy
    @trip = Trip.find(params[:trip_id])
    @traveler = @trip.travelers.find(params[:id])
    @traveler.destroy

    render json: {message: "Traveler deleted"}
  end
end
