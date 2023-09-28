class TripsController < ApplicationController
  def index
    @trips = Trip.all
    render :index
  end
end
