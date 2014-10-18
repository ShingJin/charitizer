class AddFrequencyToShop < ActiveRecord::Migration
  def change
    add_column :shops, :frequency, :integer
  end
end
