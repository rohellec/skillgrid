class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  def ==(cart_item)
    product == cart_item.product
  end

  def eql?(cart_item)
    product.eql?(cart_item.product)
  end

  def hash
    product.hash
  end
end
