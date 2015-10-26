require 'rails_helper'

describe CartItem do
  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
  let(:cart_item) { FactoryGirl.create(:cart_item, cart: user.cart, product: product) }

  subject { cart_item }

  it { should respond_to(:product) }
  it { should respond_to(:cart) }

  describe "shoud be equal to another item created for the same product" do
    let(:item) { FactoryGirl.create(:cart_item, cart: cart_item.cart, product: cart_item.product) }
    specify { expect(cart_item).to eq item }
  end
end
