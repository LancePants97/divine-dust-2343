require "rails_helper"

RSpec.describe Flight, type: :model do
  describe "relationships" do
    it { should belong_to :airline }
    it { should have_many :passenger_flights }
    it { should have_many(:passengers).through(:passenger_flights) }
  end

  before(:each) do
    @airline1 = Airline.create!(name: "United")
    @airline2 = Airline.create!(name: "Spirit")

    @flight1 = Flight.create!(number: "1234", date: "08/05/24", departure_city: "Denver", arrival_city: "Reno", airline_id: @airline1.id) # 3 passengers
    @flight3 = Flight.create!(number: "9876", date: "08/05/24", departure_city: "NYC", arrival_city: "Kansas City", airline_id: @airline2.id) # 1 passenger
  end

  describe "instance methods" do
    it "airline_name" do
      expect(@flight1.airline_name).to eq("United")
      expect(@flight3.airline_name).to eq("Spirit")
    end
  end
end
