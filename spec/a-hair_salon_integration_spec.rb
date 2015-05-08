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
    fill_in("stylist_name", :with => "Brenda")
    click_button('add_stylist')
    expect(page).to(have_content("Brenda"))
  end
end
