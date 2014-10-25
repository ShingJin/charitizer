class AddWtextToShop < ActiveRecord::Migration
  def change
    add_column :shops, :wtext, :text
  end
end
