require 'rails_helper'

describe "Cart Page" do
  subject { page }

  describe "for non-logged-in user" do
    before { visit cart_path }

    it { should have_title("Log in") }
    it { should have_warning_message("log in") }

    describe "after logging in" do
      let(:password) { "foobar" }
      let(:user) { FactoryGirl.create(:user, password: password) }
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: password
        click_button "Log in"
      end

      it { should have_title("Cart") }
      it { should have_selector("h1", text: "Your cart") }
    end
  end
end
