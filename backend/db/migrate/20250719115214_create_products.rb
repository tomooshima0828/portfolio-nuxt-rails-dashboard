class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.integer :price, null: false
      t.integer :popularity
      t.float :rating

      t.timestamps
    end

    add_index :products, :category
  end
end
