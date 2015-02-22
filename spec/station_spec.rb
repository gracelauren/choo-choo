require('spec_helper')

describe(Station) do
  it{ should have_and_belong_to_many(:lines)}
  it{ should validate_presence_of(:name)}
  it{ should validate_uniqueness_of(:name)}

  it("will capitalize the name of a station") do
    station1= Station.create({ :name => "birdmont" })
    expect(station1.name()).to eq("Birdmont")
  end

  it("will order the stations alphabetically") do
    station2= Station.create({:name => "Birdmont" })
    station1= Station.create({:name => "Kenzington" })
    expect(Station.all()).to eq([station2, station1])
  end

  describe('#lines_not_added') do
    it("display lines not added") do
      station1= Station.create({:name => "Birdmont" })
      line1= Line.create({ :name => "Red" })
      line2= Line.create({ :name => "Blue" })
      station1.lines.push(line1)
      expect(station1.lines_not_added()).to eq([line2])
    end
  end
end
