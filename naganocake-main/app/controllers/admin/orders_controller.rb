class Admin::OrdersController < ApplicationController
    def index
        @orders = Order.all
        @orders = Order.page(params[:page]).per(10)  # 10件ずつ表示
      end
    
      def show
        @order = Order.find(params[:id])
        #@order_detail = OrderDetail.find(params[:id])
        
        @total_amount = 0 # 商品合計を求める
        @order.order_details.each do |order_detail|
          @total_amount += order_detail.price * order_detail.quantity
        end
    
      end
    
      def update
        order = Order.find(params[:id])
        
        order.update(status: params[:order][:status])
        flash[:notice] = "更新成功"
        
        # 注文ステータスが"入金確認"になったら、紐づく注文商品全ての製作ステータスを"製作待ち"に更新
        if order.status == "payment_confirmed"
          order.order_details.update(status: "waiting_for_production")
        end
        
        redirect_to admin_order_path(params[:id])
      end
    
      # def order_params
      #   params.require(:order).permit(:customer_id,:postal_code,:address,:name,:method,:amount,:status,:postage)
      # end
end
