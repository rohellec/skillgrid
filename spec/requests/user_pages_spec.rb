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
      before { fill_in_user_form(user) }

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

  describe "Edit page" do
    let(:title)   { "Edit user" }
    let(:heading) { "Update your profile" }
    let(:submit)  { "Save changes" }
    let(:user) { FactoryGirl.create(:user) }
    before do
      valid_log_in(user)
      visit edit_user_path(user)
    end

    it_should_behave_like "user pages"

    describe "with invalid submission" do
      before { click_button submit }

      it_should_behave_like "user pages"
      it { should have_error_message("error") }
    end

    describe "with valid submission" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "newemail@example.com" }

      before do
        fill_in_user_form(user, name: new_name, email: new_email)
        click_button submit
      end

      it { should have_title(new_name) }
      it { should have_success_message("updated") }
      it { should have_link("Log out")}
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
