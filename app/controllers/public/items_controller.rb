class Public::ItemsController < ApplicationController
 def top
  @items = Item.all
 end

 def index
  @items = Item.all.page(params[:page])
  @genres = Genre.only_active
    if params[:genre_id]
      @genre = @genres.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.where_genre_active.includes(:genre)
    end
    @items = all_items.page(params[:page]).per(12)
    @all_items_count = all_items.count
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
