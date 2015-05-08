require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("The path to the index page.", {:type => :feature}) do
  it("Displays a welcome page.") do
    visit('/')
    expect(page).to(have_content("Hair Salon"))
  end
end

describe("The path to the stylists page.", {:type => :feature}) do
  it("Displays a welcome page with a link to the stylists page.") do
    visit('/')
    click_link('stylists')
    expect(page).to(have_content("List of Stylists:"))
  end
end

describe("The path to add a stylist.", {:type => :feature}) do
  it("Displays a form on the stylists page that adds a stylist when submitted.") do
    visit('/')
    click_link('stylists')
    fill_in("stylist_name", :with => "Ray")
    click_button('add_stylist')
    expect(page).to(have_content("Ray"))
  end
end

describe("The path to visit a stylist's page.", {:type => :feature}) do
  it("Displays a link on the stylists page to each stylist's individual page.") do
    test_stylist = Stylist.new({:id => nil, :name => "Ray"})
    test_stylist.save()
    visit('/')
    click_link('stylists')
    click_link(test_stylist.id)
    expect(page).to(have_content(test_stylist.name))
  end
end

describe("The path to update a stylist's name.", {:type => :feature}) do
  it("Displays a form on a stylist's individual page that updates their name when submitted.") do
    test_stylist = Stylist.new({:id => nil, :name => "Ray"})
    test_stylist.save()
    visit('/')
    click_link('stylists')
    click_link(test_stylist.id)
    fill_in('new_name', :with => "Tina")
    click_button('update_stylist')
    expect(page).to(have_content("Tina"))
  end
end

describe("The path to delete a stylist.", {:type => :feature}) do
  it("Displays a button on a stylist's individual page to delete them.") do
    test_stylist = Stylist.new({:id => nil, :name => "Ray"})
    test_stylist.save()
    visit('/')
    click_link('stylists')
    click_link(test_stylist.id)
    click_button('delete_stylist')
    expect(page).to(have_no_content("Ray"))
  end
end

describe("The path to the clients page.", {:type => :feature}) do
  it("Displays a welcome page with a link to the clients page.") do
    visit('/')
    click_link('clients')
    expect(page).to(have_content("List of Clients:"))
  end
end

describe("The path to add a client.", {:type => :feature}) do
  it("Displays a form on the clients page that adds a client when submitted.") do
    visit('/')
    click_link('clients')
    fill_in("client_name", :with => "Jeremy")
    click_button('add_client')
    expect(page).to(have_content("Jeremy"))
  end
end

describe("The path to visit a client's page.", {:type => :feature}) do
  it("Displays a link on the clients page to each client's individual page.") do
    test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
    test_client.save()
    visit('/')
    click_link('clients')
    click_link(test_client.id)
    expect(page).to(have_content(test_client.name))
  end
end

describe("The path to update a client's name.", {:type => :feature}) do
  it("Displays a form on a client's individual page that updates their name when submitted.") do
    test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
    test_client.save()
    visit('/')
    click_link('clients')
    click_link(test_client.id)
    fill_in('new_name', :with => "Mary")
    click_button('update_client')
    expect(page).to(have_content("Mary"))
  end
end

describe("The path to assign a client to a stylist.", {:type => :feature}) do
  it("Displays a form on a stylist's individual page that assigns a client to them when submitted.") do
    test_stylist = Stylist.new({:id => nil, :name => "Ray"})
    test_stylist.save()
    test_client = Client.new({:id => nil, :name => "Jeremy", :stylist_id => nil})
    test_client.save()
    visit('/')
    click_link('stylists')
    click_link(test_stylist.id)
    select(test_client.name, :from => "client_dropdown")
    click_button('assign_client')
    expect(page).to(have_content("Jeremy"))
  end
end
