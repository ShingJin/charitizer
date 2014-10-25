class AddLinkToRule < ActiveRecord::Migration
  def change
    add_column :rules, :link, :string
  end
end
