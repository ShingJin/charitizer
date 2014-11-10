class AddPaymentsToRules < ActiveRecord::Migration
  def change
    add_column :rules, :payments, :integer, array:true
  end
end
