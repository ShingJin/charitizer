class AddFirstCreatedToRules < ActiveRecord::Migration
  def change
    add_column :rules, :first_created, :datetime
  end
end
