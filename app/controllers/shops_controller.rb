class ShopsController < ApplicationController
	def update
	      @shop = Shop.find(session[:shopify])
    	  @shop.wtitle = params["shop"]["title"]
          @shop.wtext = params["shop"]["text"]
          @shop.save

	    respond_to do |format|
	        format.html { redirect_to '/', notice: 'Your settting was successfully updated.' }
	    end
	end

	def get_widget_info
		@shop = Shop.where("domain =?", params["domain"]).first
		respond_to do |format|  ## Add this
  	    	format.json { render json: {:title => @shop.wtitle, :text=> @shop.wtext}.to_json, status: :ok}
  			    format.html 
  		end
	end


end
