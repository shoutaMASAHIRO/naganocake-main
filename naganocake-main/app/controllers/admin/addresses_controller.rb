class Admin::AddressesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_customer

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
  
    def index
        @customer = Customer.find(params[:customer_id])
        @addresses = @customer.addresses
        @address = Address.new
    end
      
    def show
      @address = @customer.addresses.find(params[:id])
    end
  
    def edit
      @address = @customer.addresses.find(params[:id])
    end

    def create
        @address = @customer.addresses.build(address_params)
        if @address.save
          redirect_to admin_customer_addresses_path(@customer), notice: '配送先を追加しました'
        else
          @addresses = @customer.addresses
          render :index
        end
    end      
  
    def update
      @address = @customer.addresses.find(params[:id])
      if @address.update(address_params)
        flash[:success] = "配送先情報が更新されました"
        redirect_to admin_customer_addresses_path(@customer)
      else
        render :edit
      end
    end

    def destroy
        address = Address.find(params[:id])
        address.destroy
        redirect_to admin_customer_addresses_path(params[:customer_id]), notice: "配送先を削除しました。"
    end
  
    private
  
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
  
    def address_params
      params.require(:address).permit(:postal_code, :address, :name)
    end
  end
  