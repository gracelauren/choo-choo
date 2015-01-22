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

post('/operator') do
  @stations = Station.all()
  @lines = Line.all()
  erb(:operator)
end

post('/station') do
  @stations = Station.all()
  station_name = params.fetch('station_name')
  @station = Station.new({:name => station_name})
  @station.save()
  redirect("/operator")
end

post('/line') do
  @lines = Line.all()
  line_name = params.fetch('line_name')
  @line = Line.new({:name => line_name})
  @line.save()
  redirect("/operator")
end

get('/station/:id') do
  @station = Station.find(params.fetch("id").to_i())
  erb(:station)
end

get('/line/:id') do
  @line = Line.find(params.fetch("id").to_i())
  erb(:line)
end

get('/rider') do
  @stations = Station.all()
  @lines = Line.all()
  erb(:rider)
end

post('/lines') do
  @lines = Line.all()
  station_line = params.fetch('station_line')
  station_id = params.fetch("station_id").to_i()
  @line = Line.new({:name => station_line, :station_id => station_id})
  @line.save()
  @station = Station.find(station_id)
  @station.add_line(@line)
  erb(:station)
end
