desc "This task is called by the Heroku scheduler add-on"


task :update_raised_amount => :environment do
	for shop in Shop.all 
	       
	       ShopifyAPI::Session.temp(shop.domain, shop.token) 
	       {
	        for rule in Rule.where(:identifier=>ShopifyAPI::Shop.current.email)
	          orders = ShopifyAPI::Order.find(:all)
	          products = ShopifyAPI::Product.find(:all)
	          collections = ShopifyAPI::CustomCollection.find(:all)
	          amount = 0.0
	          raised_product_ids = []
	          #filter orders
	          if !rule.product_ids.nil?
	            raised_product_ids = rule.product_ids.map{|id| id.to_i}
	          end

	          if !rule.collection_ids.nil?
	            for cid in rule.collection_ids
	                    for c in @collections
	                      if c.id.to_i == cid.to_i
	                        for p in c.products
	                          if !raised_product_ids.include?(p.id) 
	                           raised_product_ids << p.id
	                          end
	                        end
	                     end
	                end
	            end 
	          end

	          if !rule.tags.nil?
	            for t in rule.tags
	              for p in products
	                if !p.tags.nil?
	                 if p.tags.include?(",")  
	                  for tag in p.tags.split(",")
	                    if tag == t && !raised_product_ids.include?(p.id) 
	                      raised_product_ids << p.id
	                    end
	                  end
	                 elsif p.tags == t && !raised_product_ids.include?(p.id) 
	                      raised_product_ids << p.id
	                 end
	                end
	              end
	            end

	          end


	          
	            for o in orders
	              if o.cancelled_at.nil? # && o.updated_at.to_datetime > @rule.starting_date && o.updated_at.to_datetime < @rule.ending_date
	                if rule.per_order!=nil
	                  amount = amount + (rule.by_percentage ? (rule.per_order.to_f/100)*o.total_line_items_price.to_f : rule.per_order.to_f )
	                else
	                  for item in o.line_items 
	                    if raised_product_ids.include?(item.product_id)
	                      amount = amount + (rule.by_percentage ? (rule.per_product.to_f/100)*(item.price.to_f)*(item.quantity.to_f) : (rule.per_product.to_f)*(item.quantity.to_f)) 
	                    end
	                  end
	                end
	              end
	            end

	            rule.raised = amount
	            rule.save
	        end
	       }
	 end

end

task :send_reminders => :environment do
  Reminder.send_out_emails
end