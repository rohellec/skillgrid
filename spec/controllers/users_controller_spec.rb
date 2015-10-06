require 'rails_helper'

describe UsersController do

  describe "authorization" do

    describe "for not signed in user" do
      let(:user) { FactoryGirl.create(:user) }

      describe "visiting the Settings page" do
        before { get :edit, id: user.id }
        specify { expect(response).to redirect_to login_url }
      end

      describe "submitting to the update action" do
        before { patch :update, id: user.id }
        specify { expect(response).to redirect_to login_url }
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { login_user(user) }

      describe "submitting a GET request to Users#edit" do
        before { get :edit, id: wrong_user.id }
        specify { expect(response).to redirect_to root_url }
      end

      describe "submitting a PATCH request to Users#update" do
        before { patch :update, id: wrong_user.id }
        specify { expect(response).to redirect_to root_url }
      end
    end
  end
end
