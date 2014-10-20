class AddShopIdToRules < ActiveRecord::Migration
  def change
    add_column :rules, :shop_id, :integer
  end
end
