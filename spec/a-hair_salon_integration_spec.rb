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
    click_button('update_name')
    expect(page).to(have_content("Tina"))
  end
end
