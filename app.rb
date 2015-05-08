require('pg')
require('sinatra')
require('sinatra/reloader')
require('./lib/stylist')
require('./lib/client')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'hair_salon'})

get('/') do
  erb(:index)
end

get('/stylists') do
  prep_stylists_page()
  erb(:stylists)
end

post('/stylists') do
  stylist_name = params.fetch("stylist_name")
  stylist = Stylist.new({:id => nil, :name => stylist_name})
  stylist.save()
  prep_stylists_page()
  erb(:stylists)
end

get('/stylist/:id') do
  prep_stylist_page()
  erb(:stylist)
end

post('/stylist/:id') do
  prep_stylist_page()
  assigned_client_id = params.fetch("client_dropdown")
  assigned_client = Client.find(assigned_client_id)
  assigned_client.update({:name => assigned_client.name, :stylist_id => @stylist.id})
  prep_stylist_page()
  erb(:stylist)
end

patch('/stylist/:id') do
  prep_stylist_page()
  new_name = params.fetch("new_name")
  @stylist.update({:name => new_name})
  erb(:stylist)
end

delete('/stylist/:id') do
  Stylist.find(params.fetch("id").to_i()).delete()
  prep_stylists_page()
  erb(:stylists)
end

define_method(:prep_stylists_page) do
  @stylists = Stylist.all()
end

define_method(:prep_stylist_page) do
  stylist_id = params.fetch("id").to_i()
  @stylist = Stylist.find(stylist_id)
  @clients = Client.all()
  @stylists_clients = Client.find_by_stylist_id(stylist_id)
end

get('/clients') do
  prep_clients_page()
  erb(:clients)
end

post('/clients') do
  client_name = params.fetch("client_name")
  client = Client.new({:id => nil, :name => client_name, :stylist_id => nil})
  client.save()
  prep_clients_page()
  erb(:clients)
end

get('/client/:id') do
  prep_client_page()
  erb(:client)
end

patch('/client/:id') do
  prep_client_page()
  new_name = params.fetch("new_name")
  @client.update({:name => new_name})
  erb(:client)
end

delete('/client/:id') do
  Client.find(params.fetch("id").to_i()).delete()
  prep_clients_page()
  erb(:clients)
end

define_method(:prep_clients_page) do
  @clients = Client.all()
end

define_method(:prep_client_page) do
  client_id = params.fetch("id").to_i()
  @client = Client.find(client_id)
  if(@client.stylist_id == 0)
    @stylist_message = "This client has not been assigned a stylist."
  else
    @stylist_message = "This client's stylist is: ".concat(Stylist.find(@client.stylist_id).name)
  end
end
