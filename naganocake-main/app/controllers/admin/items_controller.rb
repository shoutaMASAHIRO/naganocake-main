class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:search] == "perfect_match"
      @items = Item.where("name LIKE ?", "#{params[:word]}")
    elsif params[:search] == "forward_match"
      @items = Item.where("name LIKE ?", "#{params[:word]}%")
    elsif params[:search] == "backward_match"
      @items = Item.where("name LIKE ?", "%#{params[:word]}")
    elsif params[:search] == "partial_match"
      @items = Item.where("name LIKE ?", "%#{params[:word]}%")
    else
      @items = Item.all
    end
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def edit
    @item = Item.find(params[:id])  # 既存のアイテムを取得
    @genre = Genre.all  # ジャンルの情報を取得
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "登録成功"
      redirect_to admin_item_path(@item)
    else
      @genre = Genre.all
      render :new  # エラー表示のために @item をビューに渡す
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "商品情報が更新されました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  # 販売ステータスを切り替えるアクション
  def toggle_status
    @item = Item.find(params[:id])
    @item.update(is_deleted: !@item.is_deleted)  # ステータスを反転
    redirect_to admin_items_path, notice: "販売ステータスが変更されました。"
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :genre_id, :introduction, :is_deleted)
  end
  
end
