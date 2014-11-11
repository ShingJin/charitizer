class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :plan_id

      t.timestamps
    end
  end
end
