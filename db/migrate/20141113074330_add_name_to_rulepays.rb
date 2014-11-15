class AddNameToRulepays < ActiveRecord::Migration
  def change
    add_column :rulepays, :name, :string
  end
end
