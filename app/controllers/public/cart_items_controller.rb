class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!

  def index
   @cart_items = CartItem.where(customer_id:[current_customer.id])
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
   cart_item = CartItem.new(cart_params)
    if cart_item.save
     redirect_to '/cart_items'
    else
     flash[:notice] = "個数を選択してください"
     redirect_to request.referrer
    end
  end

  private
   def cart_params
	params.require(:cart_item).permit(:item_id, :count, :customer_id)
   end
end
