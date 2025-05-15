class CartItem < ApplicationRecord
    belongs_to :item
    belongs_to :customer
    
    validates :customer_id, presence: true
    validates :item_id, presence: true
    validates :amount, presence: true
    validates_uniqueness_of :item_id, scope: :customer_id
  
  def subtotal
    item.with_tax_price * amount
  end

end