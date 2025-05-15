class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!, except: [:top]
    def show
      @customer = Customer.find(current_customer.id)
    end
  
    def edit
      @customer = Customer.find(current_customer.id)
      unless @customer == current_customer
        redirect_to "/"
      end
    end
  
    def update
      @customer = Customer.find(current_customer.id)
      @customer.update(customer_params)
      if @customer.save
        flash[:success] = "Edit was successfully"
        redirect_to my_page_path
      else
        render :edit
      end
    end
  
    def withdraw
    end
  
    def withdraw_update
      current_customer.update(is_deleted: :true)
      flash[:success_logout] = "退会しました"
      reset_session
      
      redirect_to root_path
    end
  
    private
    def customer_params
      params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email ,:postal_code,:address,:phone_number)
    end
  end