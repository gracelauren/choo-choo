require("spec_helper")

describe(Line) do
  it{ should have_and_belong_to_many(:stations)}
  it{ should validate_presence_of(:name)}
  it{ should validate_uniqueness_of(:name)}

  it("will capitalize the name of a line") do
    line1= Line.create({ :name => "red" })
    expect(line1.name()).to eq("Red")
  end

  it("will order the lines alphabetically") do
    line2= Line.create({:name => "Green" })
    line1= Line.create({:name => "Red" })
    expect(Line.all()).to eq([line2, line1])
  end

  describe('#stations_not_added') do
    it("display stations not added") do
      line1= Line.create({:name => "Bob Dylan" })
      station1= Station.create({ :name => "Birdmont"})
      station2= Station.create({ :name => "Kenzington"})
      line1.stations.push(station1)
      expect(line1.stations_not_added()).to eq([station2])
    end
  end
end
