class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @cart_item = current_user.cart.cart_items.create(product: product)
    flash[:success] = "Product has been sucessfully added to your cart"
    redirect_to current_url
  end

  def destroy
    current_user.cart.cart_items.destroy(params[:id])
    redirect_to current_url
  end
end
