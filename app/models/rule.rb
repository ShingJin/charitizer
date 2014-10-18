class Rule < ActiveRecord::Base
	  validate :donation_rule_cannot_be_blank
	  validates :name, presence: true

	  validate :must_choose_at_least_one_product_or_collection_or_tag
	  validate :per_product_and_per_order
	  validate :starting_ending

	  def starting_ending
	  	if ending_date < starting_date
	  		error[:base] << "starting date must be earlier than ending date"
	  	end
	  end

	  
	  def donation_rule_cannot_be_blank
	  	if by_percentage.nil?
    		errors[:base] << "donation rule cannot be blank"
    	end
	  end 

	  def must_choose_at_least_one_product_or_collection_or_tag
	  	if product_ids.nil? && collection_ids.nil? && tags.nil?
    		errors[:base] << "must choose at least one product or collection or tag"
	  	end
	  end

	  def per_product_and_per_order
	  	if per_product.nil? && per_order.nil?
	  		errors[:base] << "per product and per order cannot both be blank"
	  	end 
	  end

	  def calculate_raised_amount(rule)
      @orders = ShopifyAPI::Order.find(:all)
      @products = ShopifyAPI::Product.find(:all)
      @collections = ShopifyAPI::CustomCollection.find(:all)
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
          if o.cancelled_at.nil? # && o.updated_at.to_datetime > @rule.starting_date && o.updated_at.to_datetime < @rule.ending_date
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
