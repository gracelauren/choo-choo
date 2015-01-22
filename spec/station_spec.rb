require('spec_helper')

describe(Station) do

  describe('#name') do
    it('will return the name of a station') do
      test_station = Station.new({ :name => "Gemini" })
      expect(test_station.name()).to eq("Gemini")
    end
  end

  describe(".all") do
    it("is empty as first") do
    expect(Station.all()).to eq([])
    end
  end

  describe('#save') do
    it('saves the name of a station to the stations array') do
      test_station = Station.new({ :name => 'Gemini'})
      test_station.save()
      expect(Station.all()).to eq([test_station])
    end
  end

  describe ("#==") do
    it("returns the station as equal if the new station is the same name") do
      test_station = Station.new({ :name => "Gemini" })
      test_station2 = Station.new({ :name => "Gemini" })
      expect(test_station).to eq(test_station2)
    end
  end

  describe(".find") do
    it("will find a station by its id") do
      test_station = Station.new({ :name => "Gemini" })
      test_station.save()
      test_station2 = Station.new({ :name => "Taurus" })
      test_station2.save()
      expect(Station.find(test_station.id())).to eq(test_station)
    end
  end

  describe("#lines") do
    it("returns the line for this station") do
      test_station = Station.new({ :name => "Gemini" })
      test_station.save()
      test_line = Line.new({ :name => "Red" })
      test_line2 = Line.new({ :name => "Yellow" })
      test_line.save()
      test_line2.save()
      test_station.add_line(test_line)
      test_station.add_line(test_line2)
      expect(test_station.lines()).to eq([test_line, test_line2])
    end
  end

  describe('#update') do
    it('lets you update a station in the database') do
      test_station = Station.new({ :name => "Gemini"})
      test_station.save()
      test_station.update({ :name => "Taurus" })
      expect(test_station.name()).to eq("Taurus")
    end
  end

  describe("#delete") do
    it() do
      test_station = Station.new({ :name => "Gemini"})
      test_station.save()
      test_station2 = Station.new({ :name => "Taurus"})
      test_station2.save()
      test_station.delete()
      expect(Station.all()).to eq([test_station2])
    end
  end
  
    describe('#remove_line_connection') do
    it("removes connection entry from stops table") do
      test_station = Station.new({ :name => "Gemini" })
      test_station.save()
      test_station2 = Station.new({ :name => "Taurus" })
      test_station2.save()
      test_line = Line.new({ :name => "Red"})
      test_line.save()
      test_line2 = Line.new({ :name => "Yellow"})
      test_line2.save()
      test_station.add_line(test_line)
      test_station.add_line(test_line2)
      test_station.remove_line_connection(test_line)
      expect(test_station.lines()).to(eq([test_line2]))
    end
  end

end
