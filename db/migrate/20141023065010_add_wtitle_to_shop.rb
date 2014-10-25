class AddWtitleToShop < ActiveRecord::Migration
  def change
    add_column :shops, :wtitle, :string
  end
end
