class Admin::CustomersController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      @customers = Customer.all
      @customers = Customer.page(params[:page]).per(10)
    end
  
    def show
      @customer = Customer.find(params[:id])
      @addresses = @customer.addresses          # 顧客の配送先を取得
    end
  
    def edit
      @customer = Customer.find(params[:id])
    end
  
    def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to admin_customer_path(@customer), notice: "顧客情報を更新しました。"
      else
        render :edit
      end
    end

    def toggle_status
      customer = Customer.find(params[:id])
      customer.update(is_deleted: !customer.is_deleted)
      redirect_to admin_customers_path, notice: "会員ステータスを変更しました。"
    end
  
    private
  
    def customer_params
      params.require(:customer).permit(
        :last_name, :first_name,
        :last_name_kana, :first_name_kana,
        :email, :postal_code,
        :address, :phone_number,
        :is_deleted 
      )
    end
  end
  