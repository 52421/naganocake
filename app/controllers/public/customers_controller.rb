class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!

  def show
   @customer = current_customer
    
  end

  def create
   @customer = Customer.new(customer_params)
   @customer.save
   redirect_to root_path
  end

  def edit
   @customer = current_customer
    if @customer.id != current_customer.id
     redirect_to root_path
    end
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
    reset_session
  end


 private
  def customer_params
   params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :is_valid,:reset_password_token, :password, :password_confirmation)
  end
end
