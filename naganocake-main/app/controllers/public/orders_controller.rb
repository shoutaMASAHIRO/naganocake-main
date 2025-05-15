class Public::OrdersController < ApplicationController
    def new
      @order = Order.new
    end
  
    def check
      #お届け先を指定
      @order = Order.new(order_params)
      unless @order.amount.nil? && params[:order][:select_address].nil?
        if params[:order][:select_address] == "0"
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.first_name + current_customer.last_name
          
        elsif params[:order][:select_address] == "1"
          @address = Address.find(params[:order][:address_id])
          @order.postal_code = @address.postal_code
          @order.address = @address.address
          @order.name = @address.name
          
        else
          # @order = current_customer.orders.new(order_params)
        end
        
        @cart_items = current_customer.cart_items
      
        #送料
        @order.postage = 800
        
        #商品合計を求める
        @total_amount = 0
        @cart_items.each do |cart_item|
          @total_amount += cart_item.subtotal
        end
        
        #請求金額
        @order.amount = @total_amount + @order.postage
  
      else
        render :new
      end
    end
    
    def create
      order = Order.new(order_create_params)
      order.save!
      
      cart_items = current_customer.cart_items 
        # カートアイテムをOrder_detailにコピー
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = order.id
        order_detail.item_id = cart_item.item_id # 商品IDをコピー
        order_detail.quantity = cart_item.amount # 数量をコピー
        order_detail.price = cart_item.item.with_tax_price # 商品の価格をコピー
        order_detail.status = "unable_to_start"
        order_detail.save!
      end
      
      current_customer.cart_items.destroy_all
      redirect_to complete_orders_path
    end
    
    def complete
      
    end
  
    def index
      @orders = Order.where(customer_id: current_customer.id) 
    end
  
    def show
      @order = Order.find(params[:id])
    end
    
    
    private
    def order_params
      params.require(:order).permit(:method, :postal_code, :address, :name)
    end
    
    def order_create_params
      params.require(:order).permit(:customer_id,:postal_code,:address,:name,:method,:amount,:status,:postage)
    end
  end