class AddDatesToRule < ActiveRecord::Migration
  def change
    add_column :rules, :starting_date, :datetime
    add_column :rules, :ending_date, :datetime
  end
end
