class ShopController < ApplicationController


  def update
    @shop = Shop.find(session[:shopify])
    if params["day"] == true
      @shop.frequency = 1
    elsif params["week"] == true
      @shop.frequency = 2
    elsif params["month"] == true
      @shop.frequency = 3
    end
  end

end
