class Admin::HomesController < ApplicationController
    
    def top
        @count = Order.ordered_today.count
    end
end
