class Public::CartItemsController < ApplicationController
    def index
      @cart_items = CartItem.all
      @cart_items = current_customer.cart_items.page(params[:page]).per(10)
    end
  
    def create
      if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        cart_item.amount += params[:cart_item][:amount].to_i
        cart_item.update(amount: cart_item.amount)
      else
        cart_item = current_customer.cart_items.new(cart_item_params)
        cart_item.save!
      end
      redirect_to cart_items_path
    end
  
    def update
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount = params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    end
    
    def destroy
      CartItem.find(params[:id]).destroy
      redirect_to cart_items_path
    end
  
    def destroy_all
      current_customer.cart_items.destroy_all
      redirect_to cart_items_path
    end
  
    private
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :amount)
    end
    
  end