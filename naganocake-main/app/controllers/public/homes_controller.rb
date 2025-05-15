class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top, :about]

  def top
    @genres = Genre.only_active.includes(:items)
     if params[:genre_id]
      # ジャンルが指定されている場合、かつ販売中の商品だけを取得
      @items = Item.where(genre_id: params[:genre_id], is_deleted: false).page(params[:page]).per(8)
    else
      # ジャンルが指定されていない場合、かつ販売中の商品だけを取得
      @items = Item.where(is_deleted: false).page(params[:page]).per(8)
    end
  end

  def about
  end
end
