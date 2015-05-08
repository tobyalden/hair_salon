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

define_method(:prep_stylists_page) do
  @stylists = Stylist.all()
end
