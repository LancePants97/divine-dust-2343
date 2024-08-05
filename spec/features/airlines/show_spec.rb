require "rails_helper"

RSpec.describe "airline show page" do
  before(:each) do
    @airline1 = Airline.create!(name: "United")
    @airline2 = Airline.create!(name: "Spirit")
    @airline3 = Airline.create!(name: "Frontier")
    @airline4 = Airline.create!(name: "Delta")
    @airline5 = Airline.create!(name: "JetBlue")

    @flight1 = Flight.create!(number: "1234", date: "08/05/24", departure_city: "Denver", arrival_city: "Reno", airline_id: @airline1.id) # 3 passengers
    @flight2 = Flight.create!(number: "4321", date: "08/06/24", departure_city: "Newark", arrival_city: "San Franciso", airline_id: @airline1.id) # 2 passengers
    @flight3 = Flight.create!(number: "9876", date: "08/05/24", departure_city: "NYC", arrival_city: "Kansas City", airline_id: @airline2.id) # 1 passenger
    @flight4 = Flight.create!(number: "6789", date: "08/07/24", departure_city: "Berlin", arrival_city: "Tokyo", airline_id: @airline2.id) # 3 passengers
    @flight5 = Flight.create!(number: "4567", date: "08/05/24", departure_city: "Charlotte", arrival_city: "London", airline_id: @airline3.id) # 2 passengers
    @flight6 = Flight.create!(number: "7654", date: "08/06/24", departure_city: "Las Vegas", arrival_city: "Beijing", airline_id: @airline3.id) # 1 passenger
    @flight7 = Flight.create!(number: "1928", date: "08/08/24", departure_city: "Las Angeles", arrival_city: "Honolulu", airline_id: @airline4.id) # 0 passengers
    @flight8 = Flight.create!(number: "9283", date: "08/10/24", departure_city: "Jacksonville", arrival_city: "Chicago", airline_id: @airline4.id) # 0 passengers

    @passenger1 = Passenger.create!(name: "Shaggy", age: 17) # on 2 flights
    @passenger2 = Passenger.create!(name: "Fred", age: 21) # on 2 flights
    @passenger3 = Passenger.create!(name: "Velma", age: 20) # on 1 flight
    @passenger4 = Passenger.create!(name: "Daphne", age: 18) # on 2 flights
    @passenger5 = Passenger.create!(name: "Scooby", age: 7) # on 1 flights
    @passenger6 = Passenger.create!(name: "Scrappy", age: 3) # on 4 flights
    @passenger7 = Passenger.create!(name: "Old Man Jenkins", age: 77) # on 0 flights

    PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
    PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
    PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight1.id)

    PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight2.id)
    PassengerFlight.create!(passenger_id: @passenger4.id, flight_id: @flight2.id)
    PassengerFlight.create!(passenger_id: @passenger6.id, flight_id: @flight2.id)

    PassengerFlight.create!(passenger_id: @passenger4.id, flight_id: @flight3.id)
    PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight3.id)

    PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight4.id)
    PassengerFlight.create!(passenger_id: @passenger4.id, flight_id: @flight4.id)
    PassengerFlight.create!(passenger_id: @passenger5.id, flight_id: @flight4.id)

    PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight5.id)
    PassengerFlight.create!(passenger_id: @passenger6.id, flight_id: @flight5.id)

    PassengerFlight.create!(passenger_id: @passenger6.id, flight_id: @flight6.id)
  end

  describe "as a visitor, when I visit the airline's show page" do
    it "displays a unique list of all adult passengers on this airline" do
      visit airline_path(@airline1)

      expect(page).to have_content(@passenger2.name, count: 1)
      expect(page).to have_content(@passenger3.name, count: 1)
      expect(page).to have_content(@passenger4.name, count: 1)

      expect(@passenger3.name).to appear_before(@passenger2.name)
      expect(@passenger2.name).to appear_before(@passenger4.name)

      expect(page).to_not have_content(@passenger1.name)
      expect(page).to_not have_content(@passenger5.name)
      expect(page).to_not have_content(@passenger6.name)
      expect(page).to_not have_content(@passenger7.name)
    end

    it "displays a unique list of all adult passengers on this airline" do
      visit airline_path(@airline2)

      expect(page).to have_content(@passenger2.name, count: 1)
      expect(page).to have_content(@passenger4.name, count: 1)

      expect(@passenger2.name).to appear_before(@passenger4.name)
      
      expect(page).to_not have_content(@passenger1.name)
      expect(page).to_not have_content(@passenger3.name)
      expect(page).to_not have_content(@passenger5.name)
      expect(page).to_not have_content(@passenger6.name)
      expect(page).to_not have_content(@passenger7.name)
    end

    it "displays a unique list of all adult passengers on this airline sorted by how many flights a passenger has taken with them" do
      visit airline_path(@airline3)

      expect(page).to have_content(@passenger2.name, count: 1)

      expect(page).to_not have_content(@passenger1.name)
      expect(page).to_not have_content(@passenger3.name)
      expect(page).to_not have_content(@passenger4.name)
      expect(page).to_not have_content(@passenger5.name)
      expect(page).to_not have_content(@passenger6.name)
      expect(page).to_not have_content(@passenger7.name)
    end

    it "displays a unique list of all adult passengers on this airline" do
      visit airline_path(@airline4)

      expect(page).to_not have_content(@passenger1.name)
      expect(page).to_not have_content(@passenger2.name)
      expect(page).to_not have_content(@passenger3.name)
      expect(page).to_not have_content(@passenger4.name)
      expect(page).to_not have_content(@passenger5.name)
      expect(page).to_not have_content(@passenger6.name)
      expect(page).to_not have_content(@passenger7.name)
    end
  end
end