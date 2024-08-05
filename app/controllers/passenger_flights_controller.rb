class PassengerFlightsController < ApplicationController
  def destroy
    PassengerFlight.find_by(passenger_id: params[:id], flight_id: params[:flight_id]).destroy
    redirect_to flights_path
  end
end