class AddDomainToRules < ActiveRecord::Migration
  def change
    add_column :rules, :domain, :string
  end
end
