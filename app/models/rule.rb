class Rule < ActiveRecord::Base
	  validate :donation_rule_cannot_be_blank
	  validates :name, presence: true

	  validate :must_choose_at_least_one_product_or_collection_or_tag
	  validate :per_product_and_per_order
	

	  
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

end
