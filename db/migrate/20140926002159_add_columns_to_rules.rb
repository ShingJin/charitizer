class AddColumnsToRules < ActiveRecord::Migration
  def change
  	   add_column :rules, :name, :string
  	   add_column :rules, :product_ids, :integer, :array => true
       add_column :rules, :collection_ids, :integer, :array => true
       add_column :rules, :tag_ids, :integer, :array => true
       add_column :rules, :by_percentage, :boolean
       add_column :rules, :percentage, :integer
       add_column :rules, :fixed_amount, :integer
       add_column :rules, :raised, :integer
       add_column :rules, :timeframe, :string
       add_column :rules, :amount_due, :integer
       add_column :rules, :paid, :boolean
  end
end
