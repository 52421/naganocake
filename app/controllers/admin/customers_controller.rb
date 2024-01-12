class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!

 def index
  @customers = Customer.all.page(params[:page])
  @customer = current_customer
 end

 def show
  @customer = Customer.find(params[:id])
 end

 def edit
  @customer = Customer.find(params[:id])
 end

 def update
  @customer = Customer.find(params[:id])
   if @customer.update(customer_params)
    redirect_to admin_customer_path(@customer)
   else
    flash[:notice] = "項目を正しく記入してください"
    redirect_to request.referrer
   end
 end

private
 def customer_params
  params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :is_valid)
 end
end
