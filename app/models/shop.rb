 class Shop < ActiveRecord::Base
   has_many :rules, :dependent => :destroy
   def self.store(session)
     s = Shop.where("domain =?",session.url)
     if s==[]
      shop = Shop.new(domain: session.url, token: session.token)
      ShopifyAPI::Session.temp(shop.domain, shop.token) {shop.email = ShopifyAPI::Shop.current.email}
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
