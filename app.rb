require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/line")
require("./lib/station")
require("pg")
require("pry")

DB = PG.connect({ :dbname => "train_system" })

get('/') do
  erb(:index)
end

get('/operator') do
  @lines = Line.all()
  @stations = Station.all()
  erb(:operator)
end

post('/station') do
  @stations = Station.all()
  station_name = params.fetch('station_name')
  @station = Station.new({:name => station_name})
  @station.save()
  redirect('/operator')
end

post('/line') do
  @lines = Line.all()
  line_name = params.fetch('line_name')
  @line = Line.new({:name => line_name})
  @line.save()
  redirect('/operator')
end

get('/station/:id') do
  @station = Station.find(params.fetch('id').to_i())
  erb(:station)
end

get('/line/:id') do
  @line = Line.find(params.fetch('id').to_i())
  erb(:line)
end

get('/rider') do
  @stations = Station.all()
  @lines = Line.all()
  erb(:rider)
end

post('/lines') do
  @lines = Line.all()
  line_id = params.fetch('line_id').to_i()
  station_id = params.fetch('station_id').to_i()
  @station = Station.find(station_id)
  @line = Line.find(line_id)
  @station.add_line(@line)
  erb(:station)
end

post('/stations') do
  @stations = Station.all()
  line_station = params.fetch('line_station')
  line_id = params.fetch('line_id').to_i()
  @station = Station.new({:name => line_station, :line_id => line_id})
  @station.save()
  @line = Line.find(line_id)
  @line.add_station(@station)
  erb(:line)
end
