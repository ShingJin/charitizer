class AddTagsToRule < ActiveRecord::Migration
  def change
      add_column :rules, :tags, :string, array:true
  end
end
