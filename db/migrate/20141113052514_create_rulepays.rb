class CreateRulepays < ActiveRecord::Migration
  def change
    create_table :rulepays do |t|
      t.boolean :paid
      t.integer :amount
      t.string :identifier
      t.datetime :starting_date
      t.datetime :ending_date

      t.timestamps
    end
  end
end
