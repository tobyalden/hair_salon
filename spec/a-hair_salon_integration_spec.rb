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
