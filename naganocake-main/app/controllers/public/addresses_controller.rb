class Public::AddressesController < ApplicationController
    def index
      @addresses = current_customer.addresses
      @address = Address.new
    end
    
    def create
      @address = current_customer.addresses.new(address_params)
      
      if @address.save
        redirect_to addresses_path
      else
        @addresses = current_customer.addresses  # ログイン中の顧客の配送先のみ取得
        render :index
      end
    end
    
  
    def edit
      @customer = current_customer  # ログイン中の顧客を取得
      @address = @customer.addresses.find(params[:id])  # 顧客の配送先を取得
    end
    
    def update
      @address = Address.find(params[:id])
      
      if @address.update(address_params)  # update メソッドを使用
        redirect_to addresses_path, notice: "配送先が更新されました"
      else
        render :edit  # update に失敗した場合は、再度 edit ページを表示
      end
    end
    
    
    def destroy
      Address.find(params[:id]).destroy
      redirect_to addresses_path
    end
    
    private 
    def address_params
      params.require(:address).permit(:postal_code, :address, :name)
    end
    
  end