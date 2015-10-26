class CartsController < ApplicationController
  before_action :require_login

  def show
    @cart = current_user.cart
    @items_quantity = Hash.new(0)
    @cart_items = @cart.cart_items
    @cart_items.each { |item| @items_quantity[item] += 1 }
  end

  private
    def not_authenticated
      flash[:warning] = "Please log in first"
      redirect_to login_url
    end
end
