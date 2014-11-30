class AddNotifiedToRules < ActiveRecord::Migration
  def change
    add_column :rules, :notified, :boolean
  end
end
