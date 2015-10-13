require 'rails_helper'

describe "Authentication Pages" do
  subject { page }

  shared_examples_for "logged in layout" do
    it { should have_link("Products") }
    it { should have_link("Profile") }
    it { should have_link("Log out") }
    it { should_not have_link("Log in") }
  end

  shared_examples_for "logged out layout" do
    it { should_not have_link("Products") }
    it { should_not have_link("Profile") }
    it { should_not have_link("Log out") }
    it { should have_link("Log in") }
  end

  describe "Log in Page" do
    before { visit login_path }

    it { should have_title('Log in') }
    it { should have_selector('h1', text: 'Log in') }

    describe "authenticate" do

      describe "with invalid information" do
        before { click_button "Log in" }

        it { should have_error_message('Incorrect') }
        it { should have_title('Log in') }
        it_should_behave_like "logged out layout"

        describe "after redirecting to home page" do
          before { visit root_path }
          it { should_not have_error_message('Incorrect') }
          it { should have_title('Skillgrid') }
        end
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before { valid_log_in(user) }

        it { should have_title(user.name) }
        it_should_behave_like "logged in layout"

        describe "followed by log out" do
          before { click_link "Log out" }

          it { should have_title('Skillgrid') }
          it_should_behave_like "logged out layout"

          describe "and then log out from another browser window" do
            before { delete logout_path }

            it { should have_title('Skillgrid') }
            it_should_behave_like "logged out layout"
          end
        end
      end
    end
  end

  describe "authorization" do
    let(:user) { FactoryGirl.create(:user) }

    describe "for non-signed in user when attempting to access protected page" do
      before { visit edit_user_path(user) }
      it { should have_title("Log in") }
      it { should have_warning_message("log in") }

      describe "after signing in" do
        before do
          fill_in "Email", with: user.email
          fill_in "Password", with: "foobar"
          click_button "Log in"
        end

        it { should have_title("Edit user") }
      end
    end
  end
end
