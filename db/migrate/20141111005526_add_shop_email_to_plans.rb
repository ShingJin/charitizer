class AddShopEmailToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :shop_email, :string
  end
end
