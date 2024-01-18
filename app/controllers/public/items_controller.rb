class Public::ItemsController < ApplicationController
 def top
  @items = Item.all
 end

 def index
  @items = Item.all.page(params[:page])
 end

 
 def show
  @item = Item.find(params[:id])
  @cart_item = CartItem.new
  @post_comment = PostComment.new
 end

 def about
 end
 
  private

  def items_params
    params.require(:item).permit(:name, :price, :introduction, :image_id)
  end
end
