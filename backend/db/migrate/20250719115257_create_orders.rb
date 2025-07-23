class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.datetime :order_date, null: false
      t.integer :total_amount, null: false

      t.timestamps
    end

    add_index :orders, :order_date
  end
end
