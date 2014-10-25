class AddPermanentToRule < ActiveRecord::Migration
  def change
    add_column :rules, :permanent, :boolean
  end
end
