class AddImageUrlToCabins < ActiveRecord::Migration[7.1]
  def change
    add_column :cabins, :imageUrl, :string, null: false
  end
end
