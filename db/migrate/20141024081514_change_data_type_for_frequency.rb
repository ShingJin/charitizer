class ChangeDataTypeForFrequency < ActiveRecord::Migration
  def change
  	    change_column :rules, :frequency, :string

  end
end
