require 'rails_helper'
require_relative '../support/utilities.rb'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('h1', text: "Skillgrid") }
  end

  describe "navigation" do
    it "should have right links on the layout" do
      visit root_path
      click_link "About"
      expect(page).to have_title(full_title("About"))
      click_link "Home"
      expect(page).to have_title(full_title(''))
    end
  end
end
