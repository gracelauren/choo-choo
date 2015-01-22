require("spec_helper")

describe(Line) do
  describe("#name") do
    it("return the name of the line") do
      test_line = Line.new({ :name => "Red" })
      expect(test_line.name()).to eq("Red")
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Line.all()).to eq([])
    end
  end

  describe("#save") do
    it("saves the new line into the array of lines") do
      test_line = Line.new({ :name => "Red" })
      test_line.save()
      expect(Line.all()).to eq([test_line])
    end
  end

  describe('#==') do
    it('returns the lines as equal if the name and the id are the same') do
      test_line = Line.new({ :name => "Red" })
      test_line2 = Line.new({ :name => "Red" })
      expect(test_line).to eq(test_line2)
    end
  end

  describe(".find") do
    it("will find a line by its id") do
      test_line = Line.new({ :name => "Red" })
      test_line.save()
      test_line2 = Line.new({ :name => "Yellow" })
      test_line2.save()
      expect(Line.find(test_line.id())).to eq(test_line)
    end
  end

  describe('#stations') do
    it('returns the stations each line goes to') do
      test_line = Line.new({ :name => "Red" })
      test_line.save()
      test_station = Station.new({ :name => "Gemini" })
      test_station2 = Station.new({ :name => "Virgo" })
      test_station.save()
      test_station2.save()
      test_line.add_station(test_station)
      test_line.add_station(test_station2)
      expect(test_line.stations()).to eq([test_station, test_station2])
    end
  end

  describe("#update") do
    it("lets you update lines in the database") do
      test_line = Line.new({ :name => "Red" })
      test_line.save()
      test_line.update({ :name => "Yellow" })
      expect(test_line.name()).to eq("Yellow")
    end
  end

  describe('#delete') do
    it('lets you delete a list from the database') do
      test_line = Line.new({ :name => "Red" })
      test_line.save()
      test_line2 = Line.new({ :name => "Yellow" })
      test_line2.save()
      test_line.delete()
      expect(Line.all()).to eq([test_line2])
    end
  end
  
    describe('#remove_station_connection') do
    it("removes connection entry from stops table") do
      test_station = Station.new({ :name => "Gemini" })
      test_station.save()
      test_station2 = Station.new({ :name => "Taurus" })
      test_station2.save()
      test_line = Line.new({ :name => "Red"})
      test_line.save()
      test_line2 = Line.new({ :name => "Yellow"})
      test_line2.save()
      test_line.add_station(test_station)
      test_line.add_station(test_station2)
      test_line.remove_station_connection(test_station)
      expect(test_line.stations()).to(eq([test_station2]))
    end
  end
end
