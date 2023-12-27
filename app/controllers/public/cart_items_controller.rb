class Public::CartItemsController < ApplicationController
 before_action :authenticate_customer!
 before_action :set_cart_item, only: %i[increase decrease destroy]

  def index
   @cart_items = current_customer.cart_items
  end

  def destroy
   cart_item = CartItem.find(params[:id])
   cart_item.destroy
   redirect_to '/cart_items'
  end

  def update
   cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_params)
     redirect_to '/cart_items'
    end
  end

  def destroy_all
   cart_items = CartItem.where(customer_id:[current_customer.id])
   cart_items.each do |cart_item|
   cart_item.destroy
   end
    redirect_to '/cart_items'
  end

  def create
   cart_item = CartItem.new(cart_item_params)
    if cart_item.save
     redirect_to '/cart_items'
    else
     flash[:notice] = "個数を選択してください"
     redirect_to request.referrer
    end
  end

 private
  def cart_item_params
    params.require(:cart_item).permit(:name, :price, :customer_id, :item_id, :amount)
  end
end
