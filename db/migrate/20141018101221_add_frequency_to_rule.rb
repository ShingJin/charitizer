class AddFrequencyToRule < ActiveRecord::Migration
  def change
    add_column :rules, :frequency, :integer
  end
end
