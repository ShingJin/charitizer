class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def index
    # get 10 products
    @products = ShopifyAPI::Product.find(:all)
    # get latest 5 orders
    @orders   = ShopifyAPI::Order.find(:all)
    @rules = Rule.where(:identifier=>ShopifyAPI::Shop.current.email)
  end
  
  def widgets
    @shop = Shop.find(session[:shopify])
  end


  def test_fixtures


    #a cup $5
    cup = ShopifyAPI::Product.new
    cup.title = "cup"
    cup.price = 3
    cup.save
    #a monitor $30

    #a table $40

    #a mouse $13

    #a keyboard $5

    #a laptop $300

    #simple package - a cup, a table

    #normal package - a cup, a monitor, a keyboard

    #complex package - a cup, a monitor, a laptop, a table

  end


end