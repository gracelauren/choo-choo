require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("./lib/list")
require("pg")

DB = PG.connect({ :dbname => "train_system" })

get('/') do
  erb(:index)
end

post('/operators') do
  erb(:operator)
end

post('/riders') do
  erb(:rider)

end
