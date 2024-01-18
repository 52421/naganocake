class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!,only: [:edit,:update,:show]

  def new
    @item = Item.new
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      all_items = @genre.items
    else
      all_items = Item.includes(:genre)
    end
    @items = all_items.page(params[:page])
    @all_items_count = all_items.count
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      flash.now[:success] = "商品の新規登録が完了しました。"
       redirect_to admin_item_path(@item)
    else
      flash.now[:danger] = "商品の新規登録内容に不備があります。"
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

 def update
  @item = Item.find_by(id: params[:id])
  if @item
    # 商品が存在する場合の処理
    if @item.update(item_params)
      flash.now[:success] = "商品詳細の変更が完了しました。"
      redirect_to admin_item_path(@item)
    else
      flash.now[:danger] = "商品詳細の変更内容に不備があります。"
      render :edit
    end
  else
    # 商品が存在しない場合の処理
    flash.now[:danger] = "指定された商品は存在しません。"
    redirect_to root_path
  end
 end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :image )
  end
end
