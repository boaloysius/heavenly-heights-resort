class MakeCabinNameUnique < ActiveRecord::Migration[7.1]
  def change
    add_index :cabins, :name, unique: true
  end
end
