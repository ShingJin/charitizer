class AddPaidAmountToRules < ActiveRecord::Migration
  def change
    add_column :rules, :paid_amount, :integer
  end
end
