class ProductsController < ApplicationController

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
  end

  private
    def product_params
      params.require(:product).permit(:photo, :title, :description)
    end
end
