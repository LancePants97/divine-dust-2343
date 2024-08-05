require "rails_helper"

RSpec.describe "flights index page" do
  before(:each) do
    @airline1 = Airline.create!(name: "United")
    @airline2 = Airline.create!(name: "Spirit")
    @airline3 = Airline.create!(name: "Frontier")
    @airline4 = Airline.create!(name: "Delta")
    @airline5 = Airline.create!(name: "JetBlue")

    @flight1 = Flight.create!(number: "1234", date: "08/05/24", airline_id: @airline1.id) # 3 passengers
    @flight2 = Flight.create!(number: "4321", date: "08/06/24", airline_id: @airline1.id) # 2 passengers
    @flight3 = Flight.create!(number: "9876", date: "08/05/24", airline_id: @airline2.id) # 1 passenger
    @flight4 = Flight.create!(number: "6789", date: "08/07/24", airline_id: @airline2.id) # 3 passengers
    @flight5 = Flight.create!(number: "4567", date: "08/05/24", airline_id: @airline3.id) # 2 passengers
    @flight6 = Flight.create!(number: "7654", date: "08/06/24", airline_id: @airline3.id) # 1 passenger
    @flight7 = Flight.create!(number: "1928", date: "08/08/24", airline_id: @airline4.id) # 0 passengers
    @flight8 = Flight.create!(number: "9283", date: "08/10/24", airline_id: @airline4.id) # 0 passengers

    @passenger1 = Passenger.create!(name: "Shaggy", age: 19) # on 2 flights
    @passenger2 = Passenger.create!(name: "Fred", age: 21) # on 2 flights
    @passenger3 = Passenger.create!(name: "Velma", age: 20) # on 1 flight
    @passenger4 = Passenger.create!(name: "Daphne", age: 23) # on 2 flights
    @passenger5 = Passenger.create!(name: "Scooby", age: 7) # on 1 flights
    @passenger6 = Passenger.create!(name: "Scrappy", age: 3) # on 4 flights
    @passenger7 = Passenger.create!(name: "Old Man Jenkins", age: 77) # on 0 flights

    PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight1.id)
    PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight1.id)
    PassengerFlight.create!(passenger_id: @passenger3.id, flight_id: @flight1.id)

    PassengerFlight.create!(passenger_id: @passenger1.id, flight_id: @flight2.id)
    PassengerFlight.create!(passenger_id: @passenger4.id, flight_id: @flight2.id)

    PassengerFlight.create!(passenger_id: @passenger6.id, flight_id: @flight3.id)

    PassengerFlight.create!(passenger_id: @passenger4.id, flight_id: @flight4.id)
    PassengerFlight.create!(passenger_id: @passenger5.id, flight_id: @flight4.id)
    PassengerFlight.create!(passenger_id: @passenger6.id, flight_id: @flight4.id)

    PassengerFlight.create!(passenger_id: @passenger2.id, flight_id: @flight5.id)
    PassengerFlight.create!(passenger_id: @passenger6.id, flight_id: @flight5.id)

    PassengerFlight.create!(passenger_id: @passenger6.id, flight_id: @flight6.id)
  end

  describe "as a visitor, when I visit the flights index page" do
    it "displays a list of all flight numbers, their airlines, and all passengers on that flight" do
      visit flights_path
      
      within("#flights") do
        expect(page).to have_content("Flight Number: #{@flight1.number}")
        expect(page).to have_content("Flight Number: #{@flight2.number}")
        expect(page).to have_content("Flight Number: #{@flight3.number}")
        expect(page).to have_content("Flight Number: #{@flight4.number}")
        expect(page).to have_content("Flight Number: #{@flight5.number}")
        expect(page).to have_content("Flight Number: #{@flight6.number}")
        expect(page).to have_content("Flight Number: #{@flight7.number}")
        expect(page).to have_content("Flight Number: #{@flight8.number}")
      end

      within("#flight-#{@flight1.id}") do
        expect(page).to have_content("Flight Airline: #{@airline1.name}")
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger3.name)

        expect(page).to_not have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger6.name)
        expect(page).to_not have_content(@passenger7.name)
      end

      within("#flight-#{@flight2.id}") do
        expect(page).to have_content("Flight Airline: #{@airline1.name}")
        expect(page).to have_content(@passenger1.name)
        expect(page).to have_content(@passenger4.name)

        expect(page).to_not have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger6.name)
        expect(page).to_not have_content(@passenger7.name)
      end

      within("#flight-#{@flight3.id}") do
        expect(page).to have_content("Flight Airline: #{@airline2.name}")
        expect(page).to have_content(@passenger6.name)

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to_not have_content(@passenger2.name)
        expect(page).to_not have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger7.name)
      end

      within("#flight-#{@flight4.id}") do
        expect(page).to have_content("Flight Airline: #{@airline2.name}")
        expect(page).to have_content(@passenger4.name)
        expect(page).to have_content(@passenger5.name)
        expect(page).to have_content(@passenger6.name)

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to_not have_content(@passenger2.name)
        expect(page).to_not have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger7.name)
      end

      within("#flight-#{@flight5.id}") do
        expect(page).to have_content("Flight Airline: #{@airline3.name}")
        expect(page).to have_content(@passenger2.name)
        expect(page).to have_content(@passenger6.name)

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to_not have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger7.name)
      end

      within("#flight-#{@flight6.id}") do
        expect(page).to have_content("Flight Airline: #{@airline3.name}")
        expect(page).to have_content(@passenger6.name)

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to_not have_content(@passenger2.name)
        expect(page).to_not have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger7.name)
      end

      within("#flight-#{@flight7.id}") do
        expect(page).to have_content("Flight Airline: #{@airline4.name}")

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to_not have_content(@passenger2.name)
        expect(page).to_not have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger6.name)
        expect(page).to_not have_content(@passenger7.name)
      end

      within("#flight-#{@flight8.id}") do
        expect(page).to have_content("Flight Airline: #{@airline4.name}")

        expect(page).to_not have_content(@passenger1.name)
        expect(page).to_not have_content(@passenger2.name)
        expect(page).to_not have_content(@passenger3.name)
        expect(page).to_not have_content(@passenger4.name)
        expect(page).to_not have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger6.name)
        expect(page).to_not have_content(@passenger7.name)
      end
    end

    it "has a button to remove a passenger from a singular flight" do
      visit flights_path

      within("#flight-#{@flight3.id}") do
        expect(page).to have_content(@passenger6.name)
      end

      within("#flight-#{@flight5.id}") do
        expect(page).to have_content(@passenger6.name)
      end

      within("#flight-#{@flight6.id}") do
        expect(page).to have_content(@passenger6.name)
      end

      within("#flight-#{@flight4.id}") do
        expect(page).to have_content(@passenger4.name)
        expect(page).to have_content(@passenger5.name)
        expect(page).to have_content(@passenger6.name)

        within("#passenger-#{@passenger6.id}") do
          click_button "Remove From Flight"
        end

        expect(page).to have_content(@passenger4.name)
        expect(page).to have_content(@passenger5.name)
        expect(page).to_not have_content(@passenger6.name)
      end

      within("#flight-#{@flight3.id}") do
        expect(page).to have_content(@passenger6.name)
      end

      within("#flight-#{@flight5.id}") do
        expect(page).to have_content(@passenger6.name)
      end

      within("#flight-#{@flight6.id}") do
        expect(page).to have_content(@passenger6.name)
      end
    end
  end
end