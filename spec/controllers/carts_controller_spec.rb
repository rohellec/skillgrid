require 'rails_helper'

describe CartsController do

  describe "for non-signed in users" do
    let(:user) { FactoryGirl.create(:user) }

    describe "submitting a GET request to Products#show action" do
      before { get :show, cart: user.cart }
      specify { expect(response).to redirect_to login_url }
    end
  end
end
