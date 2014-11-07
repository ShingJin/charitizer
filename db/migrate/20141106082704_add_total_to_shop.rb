class AddTotalToShop < ActiveRecord::Migration
  def change
    add_column :shops, :total, :integer
  end
end
