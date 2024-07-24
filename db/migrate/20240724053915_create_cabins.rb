class CreateCabins < ActiveRecord::Migration[7.1]
  def change
    create_table :cabins do |t|
      t.integer :maxCapacity
      t.integer :regularPrice
      t.integer :discount
      t.text :name
      t.text :image
      t.text :description

      t.timestamps
    end
  end
end
