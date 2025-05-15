class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre=Genre.new
    @genres=Genre.all
    @genres = Genre.page(params[:page]).per(10)  # 1ページに10件のジャンルを表示  
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:success] = "投稿成功"
      redirect_to admin_genres_path
    else
      @genres=Genre.all
      render :new
    end
  end
  
  def edit
    @genre=Genre.find(params[:id])
  end
  
  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    if @genre.save
      flash[:success] = "編集成功"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end
    
    
  private #createアクションの内部でのみ使用可能
	def genre_params
	    params.require(:genre).permit(:name)# ストロングパラメータ
	end
end
