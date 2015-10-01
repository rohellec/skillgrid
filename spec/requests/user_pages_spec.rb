require 'rails_helper'

describe "User pages" do
  subject { page }

  shared_examples_for "user pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(title)) }
  end

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:heading) { user.name }
    let(:title) { user.name }
    before { visit user_path(user) }

    it_should_behave_like "user pages"
  end

  describe "SignUp page" do
    let(:heading) { "Sign Up" }
    let(:title) { "Sign Up" }
    let(:submit) { "Create my account" }
    before { visit signup_path }

    it_should_behave_like "user pages"

    describe "with invalid submission" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_error_message('error') }
        it_should_behave_like "user pages"
      end
    end

    describe "with valid information" do
      let(:user) { new_user }
      let(:heading) { user.name }
      let(:title) { user.name }
      before { fill_in_signup(user) }

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_success_message('Welcome') }
        it_should_behave_like "user pages"

        describe "and returning back to home page" do
          before { visit root_path }
          it { should_not have_success_message('Welcome') }
        end
      end
    end
  end
end
