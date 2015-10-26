require 'rails_helper'

describe ProductsController do

  describe "for non-signed in users" do
    let(:user) { FactoryGirl.create(:user) }
    let(:product) { FactoryGirl.create(:product) }

    describe "submitting a GET request to Products#new action" do
      before { get :new }
      specify { expect(response).to redirect_to login_url }
    end

    describe "submitting a POST request to Products#create action" do
      before { post :create }
      specify { expect(response).to redirect_to login_url }
    end

    describe "submitting a GET request to Products#edit action" do
      before { get :edit, id: product }
      specify { expect(response).to redirect_to login_url }
    end

    describe "submitting a PATCH request to Products#update action" do
      before { patch :update, id: product }
      specify { expect(response).to redirect_to login_url }
    end

    describe "submitting a DELETE request to Products#destroy action" do
      before { delete :destroy, id: product }
      specify { expect(response).to redirect_to login_url }
    end      
  end
end
