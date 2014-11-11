class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
 

  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end
  
  def plan

    @plan = ShopifyAPI::RecurringApplicationCharge.current
    @plans = ShopifyAPI::RecurringApplicationCharge.all
  end

  def submit_plan


     charge = ShopifyAPI::RecurringApplicationCharge.create(
     name: "Default Plan",
     price: 5.00,
     trial_days: 7
  )


     plan = Plan.new
     plan.shop_email = ShopifyAPI::Shop.current.email
     plan.plan_id = charge.id
     plan.save
     redirect_to '/', notice: "You have successfully purchased this app."

  end


  def help

  end

  def submit_contact

  end

  def index
    # get 10 products
    @products = ShopifyAPI::Product.find(:all)
    # get latest 5 orders
    @orders   = ShopifyAPI::Order.find(:all)
    @rules = Rule.where(:identifier=>ShopifyAPI::Shop.current.email)
    for r in @rules
        calculate_raised_amount(r)
      end
  end
  
  def widgets
    @shop = Shop.find(session[:shopify])
  end

def get_collections
      collections = ShopifyAPI::CustomCollection.find(:all)
      smart_collections = ShopifyAPI::SmartCollection.find(:all)
      collections = collections.to_a
      for sc in smart_collections
        collections << sc
      end
      return collections
    end

    def calculate_raised_amount(rule)
      @orders = ShopifyAPI::Order.find(:all)
      @products = ShopifyAPI::Product.find(:all)
      @collections = get_collections
      @rule = rule
      @amount = 0.0
      @raised_product_ids = []
      #filter orders
      if !@rule.product_ids.nil?
        @raised_product_ids = @rule.product_ids.map{|id| id.to_i}
      end

      if !@rule.collection_ids.nil?
        for cid in @rule.collection_ids
                for c in @collections
                  if c.id.to_i == cid.to_i
                    for p in c.products
                      if !@raised_product_ids.include?(p.id) 
                       @raised_product_ids << p.id
                      end
                    end
                 end
            end
        end 
      end

      if !@rule.tags.nil?
        for t in @rule.tags
          for p in @products
            if !p.tags.nil?
             if p.tags.include?(",")  
              for tag in p.tags.split(",")
                if tag == t && !@raised_product_ids.include?(p.id) 
                  @raised_product_ids << p.id
                end
              end
             elsif p.tags == t && !@raised_product_ids.include?(p.id) 
                  @raised_product_ids << p.id
             end
            end
          end
        end

      end


      
        for o in @orders
          if (o.cancelled_at.nil? && @rule.permanent == true ) || (o.cancelled_at.nil? && o.updated_at.to_datetime > @rule.starting_date && o.updated_at.to_datetime < @rule.ending_date)
            if @rule.per_order!=nil
              @amount = @amount + (@rule.by_percentage ? (@rule.per_order.to_f/100)*o.total_line_items_price.to_f : @rule.per_order.to_f )
            else
              for item in o.line_items 
                if @raised_product_ids.include?(item.product_id)
                  @amount = @amount + (@rule.by_percentage ? (@rule.per_product.to_f/100)*(item.price.to_f)*(item.quantity.to_f) : (@rule.per_product.to_f)*(item.quantity.to_f)) 
                end
              end
            end
          end
        end

        @rule.raised = @amount
        @rule.save
    end


end