class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item

    validates :order_id, presence: true
    validates :item_id, presence: true
    validates :quantity, presence: true
    validates :price, presence: true
    validates :status, presence: true

    enum status: { unable_to_start: 0, waiting_for_production: 1, production_in_progress: 2, production_completed: 3}

    def self.statuses_i18n
      {
        unable_to_start: I18n.t('order_detail.status.unable_to_start'),
        waiting_for_production: I18n.t('order_detail.status.waiting_for_production'),
        production_in_progress: I18n.t('order_detail.status.production_in_progress'),
        production_completed: I18n.t('order_detail.status.production_completed')
      }
    end
  
    def status_i18n
      I18n.t("order_detail.status.#{status}")
    end

    def self.total_quantity_for_order(order) #クラスメソッド(インスタンスを生成せずに呼び出すことができる)
      where(order_id: order.id).sum(:quantity) # 引数として受け取ったorderのidとorder_idカラムが一致するorder_detailモデルの:quantityをすべて
    end
  
    def subtotal
      item.with_tax_price * quantity
    end
end