 class Shop < ActiveRecord::Base
   has_many :rules, :dependent => :destroy
   def self.store(session)
     s = Shop.where("domain =?",session.url)
     if s==[]
      shop = Shop.new(domain: session.url, token: session.token)
      ShopifyAPI::Session.temp(shop.domain, shop.token) {
        shop.email = ShopifyAPI::Shop.current.email
       charge = ShopifyAPI::RecurringApplicationCharge.create(
          name: "Default Plan",
          price: 5.00,
          trial_days: 7
      )

      plan = Plan.new
      plan.shop_email = shop.email
      plan.plan_id = charge.id
      plan.save
      }
       
      

      shop.save!
      shop.id
     else
      s.first.id
     end
  end

   def self.retrieve(id)
  	return if id.blank?
  	shop = Shop.find(id)
  	ShopifyAPI::Session.new(shop.domain, shop.token)
   end



   
end
