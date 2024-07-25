class RemoveImageFromCabins < ActiveRecord::Migration[7.1]
  def change
    remove_column :cabins, :image, :string
  end
end
