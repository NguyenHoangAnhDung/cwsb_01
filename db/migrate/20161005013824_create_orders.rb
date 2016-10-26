class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.float :total_paid
      t.references :venue
      t.boolean :is_ready, default: false

      t.timestamps
    end
  end
end
