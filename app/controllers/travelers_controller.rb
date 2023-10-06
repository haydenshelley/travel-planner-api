class TravelersController < ApplicationController
  def index
    @travelers = Traveler.joins(:trip).where(user_id: current_user.id, accepted: true).where.not(trips: {user_id: current_user.id})
    render :index
  end

  def show
    @travelers = Traveler.joins(:trip).where(user_id: current_user.id, accepted: true).where.not(trips: {user_id: current_user.id})
    @traveler = @travelers.find_by(id: params[:id])
    render :show
  end

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

  def pending
    @user = User.find_by(id: current_user.id)
    @pending_trip_ids = Traveler.pending_invitations(@user)
    @pending_trips = Trip.where(id: @pending_trip_ids)
    render template: 'trips/pending_trips', formats: [:json], handlers: [:jbuilder], locals: { pending_trips: @pending_trips }
  end

  def decline
    @traveler = Traveler.find_by(id: params[:traveler_id])
    @traveler.destroy

    render json: {message: "Traveler deleted"}
  end
end
