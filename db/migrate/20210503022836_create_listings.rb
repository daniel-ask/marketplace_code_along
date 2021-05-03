class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.integer :battery_capacity
      t.integer :weight
      t.text :description
      t.integer :max_speed
      t.integer :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
