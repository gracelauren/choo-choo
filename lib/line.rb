class Line
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    name = attributes.fetch(:name)
    @name = name.split.map(&:capitalize).join(' ')
    @id = attributes[:id]
  end

  define_singleton_method(:all)  do
    lines = []
    returned_lines = DB.exec("SELECT * FROM lines;")
    returned_lines.each() do |line|
      id = line.fetch("id").to_i()
      name = line.fetch("name")
      lines.push(Line.new({ :name => name, :id => id }))
    end
    lines
  end

  define_method(:save) do
    result= DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |another_name|
    self.name() == another_name.name() && self.id() == another_name.id()
  end

  define_singleton_method(:find) do |id|
    Line.all().each() do |line|
      if line.id() == id
        return line
      end
    end
  end

  define_method(:add_station) do |station|
      DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{station.id()}, #{self.id()});")
  end

  define_method(:stations) do
    all_stations = []
    returned_stations_ids = DB.exec("SELECT station_id FROM stops WHERE line_id = #{self.id()};")
    returned_stations_ids.each() do |station_id|
      station_id_int = station_id.fetch("station_id").to_i()
      returned_stations = DB.exec("SELECT * FROM stations WHERE id = #{station_id_int};")
      returned_stations.each() do |station|
        name = station.fetch("name")
        id = station.fetch("id").to_i()
        all_stations.push(Station.new({ :name => name, :id => id }))
      end
    end
    all_stations
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE lines SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM lines WHERE id = #{self.id()};")
  end

  define_method(:remove_station_connection) do |station|
    DB.exec("DELETE FROM stops WHERE line_id = #{self.id()} AND station_id = #{station.id()};")
  end

end
