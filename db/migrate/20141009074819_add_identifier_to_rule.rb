class AddIdentifierToRule < ActiveRecord::Migration
  def change
    add_column :rules, :identifier, :string
  end
end
