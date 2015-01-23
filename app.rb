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
  Line.remove_empty_name_entry()
  Station.remove_empty_name_entry()
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

post('/lines') do
  @lines = Line.all()
  line_id = params.fetch('line_id').to_i()
  station_id = params.fetch('station_id').to_i()
  @station = Station.find(station_id)
  @line = Line.find(line_id)
  @station.add_line(@line)
  erb(:station)
end

delete('/delete_line') do
  line_id = params.fetch('line_id').to_i()
  station_id = params.fetch('station_id').to_i()
  @line = Line.find(line_id)
  @station = Station.find(station_id)
  @station.remove_line_connection(@line)
  @lines = Line.all()
  url = "/station/" + station_id.to_s()
  redirect(url)
end

post('/stations') do
  @stations = Station.all()
  station_id = params.fetch('station_id').to_i()
  line_id = params.fetch('line_id').to_i()
  @line = Line.find(line_id)
  @station = Station.find(station_id)
  @line.add_station(@station)
  erb(:line)
end

delete('/delete_station') do
  line_id = params.fetch('line_id').to_i()
  station_id = params.fetch('station_id').to_i()
  @line = Line.find(line_id)
  @station = Station.find(station_id)
  @line.remove_station_connection(@station)
  @stations = Station.all()
  url = "/line/" + line_id.to_s()
  redirect(url)
end

get("/stations/:id/edit") do
  @station = Station.find(params.fetch("id").to_i())
  erb(:station_edit)
end

patch("/stations/:id") do
  name = params.fetch("name")
  @station = Station.find(params.fetch("id").to_i())
  @station.update({:name => name})
  erb(:station)
end

delete("/stations/:id") do
  @station = Station.find(params.fetch("id").to_i())
  @station.delete()
  @stations = Station.all()
  redirect('/operator')
end

get("/lines/:id/edit") do
  @line = Line.find(params.fetch("id").to_i())
  erb(:line_edit)
end

patch("/lines/:id") do
  name = params.fetch("name")
  @line = Line.find(params.fetch("id").to_i())
  @line.update({:name => name})
  erb(:line)
end

delete("/lines/:id") do
  @line = Line.find(params.fetch("id").to_i())
  @line.delete()
  @lines = Line.all()
  redirect('/operator')
end


get('/rider') do
  Line.remove_empty_name_entry()
  Station.remove_empty_name_entry()
  @stations = Station.all()
  @lines = Line.all()
  erb(:rider)
end

get('/line_stations/:line_id') do
  @stations = Station.all()
  line_id = params.fetch('line_id').to_i()
  @line = Line.find(line_id)
  erb(:line_stations)
end

get('/station_lines/:station_id') do
  @lines = Line.all()
  station_id = params.fetch('station_id').to_i()
  @station = Station.find(station_id)
  erb(:station_lines)
end
