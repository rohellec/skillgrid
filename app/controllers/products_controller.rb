class ProductsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.paginate(page: params[:page], per_page: 15)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product has been sucessfully created"
      redirect_to @product
    else
      render "new"
    end
  end

  def show
    @product = Product.find(params[:id])
    if logged_in?
      @cart_items = @product.cart_items.where(cart_id: current_user.cart)
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Product has been succesfuly updated"
      redirect_to @product
    else
      render "edit"
    end
  end

  def destroy
    Product.find(params[:id]).delete
    flash[:success] = "Product has been successfully deleted"
    redirect_to products_url
  end

  private
    def product_params
      params.require(:product).permit(:photo, :title, :description)
    end

    def not_authenticated
      flash[:warning] = "Please log in first"
      redirect_to login_url
    end
end
