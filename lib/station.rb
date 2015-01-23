class Station
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    name = attributes.fetch(:name)
    @name = name.split.map(&:capitalize).join(' ')
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    stations = []
    returned_stations = DB.exec("SELECT * FROM stations ORDER BY name;")
    returned_stations.each() do |station|
      id = station.fetch('id').to_i()
      name = station.fetch('name')
      stations.push(Station.new({:name => name, :id => id}))
    end
    stations
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING ID;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |another_station|
    self.name() == another_station.name() && self.id() == another_station.id()
  end

  define_singleton_method(:find) do |id|
    Station.all().each() do |station|
      if station.id() == id
        return station
      end
    end
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE stations SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:add_line) do |line|
    DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{self.id()}, #{line.id()});")
  end

  define_method(:lines) do
    all_lines = []
    returned_lines_ids = DB.exec("SELECT line_id FROM stops WHERE station_id = #{self.id()};")
    returned_lines_ids.each() do |line_id|
      line_id_int = line_id.fetch('line_id').to_i()
      returned_lines = DB.exec("SELECT * FROM lines WHERE id = #{line_id_int};")
      returned_lines.each() do |line|
        name = line.fetch('name')
        id = line.fetch('id').to_i()
        all_lines.push(Line.new({:name => name, :id => id }))
      end
    end
    all_lines
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stations WHERE id = #{self.id()};")
  end

  define_method(:remove_line_connection) do |line|
    DB.exec("DELETE FROM stops WHERE station_id = #{self.id()} AND line_id = #{line.id()};")
  end

  define_singleton_method(:remove_empty_name_entry) do
    DB.exec("DELETE FROM stations WHERE name = '';")
  end
end
