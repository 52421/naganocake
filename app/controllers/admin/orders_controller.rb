class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!

  def index
    @orders = Order.page(params[:page]).per(10)
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end


  def update
    @order = Order.find(params[:id])
   if @order.update(order_params)
      redirect_to admins_orders_path, notice: 'ユーザ情報を更新しました。'
   else
      render :show
    @user = @order.user
    @order_products = @order.order_products
    @order_product = OrderProduct.find(@admins_order.id)
   end

  end

private

  def order_params
    params.require(:order).permit(:status)
  end

end