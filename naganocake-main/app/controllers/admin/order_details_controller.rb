class Admin::OrderDetailsController < ApplicationController
    def update
        order_detail = OrderDetail.find(params[:id])
        order_detail.update(status: params[:order_detail][:status])
        flash[:notice] = "更新成功"
        
        order_details = OrderDetail.where(order_id: order_detail.order_id)
        # 紐づく注文商品の製作ステータスが1つでも"製作中"になったら、注文ステータスを"製作中"に更新
        order_details.each do |order_detail|
          if order_detail.status == "production_in_progress"
            order_detail.order.update(status: "in_production")
            break
          end
        end
    
        # 紐づく注文商品全ての製作ステータスが"製作完了"になったら、注文ステータスを"発送準備中"に更新
        if order_details.all? { |order_detail| order_detail.status == "production_completed" } # すべての注文商品のステータスが "製作完了" (status 3) の場合
          order_detail.order.update(status: "preparing_to_ship")
        end
        redirect_to admin_order_path(order_detail.order.id)
      end
end
