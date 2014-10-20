class ShopsController < ApplicationController
	def update
	    @shop = Shop.find(session[:shopify])
	    if params["shop"]["frequency"] == "day"
	      @shop.frequency = 1
	    elsif params["shop"]["frequency"]  == "week"
	      @shop.frequency = 2
	    elsif params["shop"]["frequency"]  == "month"
	      @shop.frequency = 3
	    end
	    @shop.save

	    respond_to do |format|
	        format.html { redirect_to '/notifications', notice: 'Your settting was successfully updated.' }
	    end
	    

	end


end
