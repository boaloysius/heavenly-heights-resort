class AddImagePublicIdToCabins < ActiveRecord::Migration[7.1]
  def change
    add_column :cabins, :imagePublicId, :string, null: false
  end
end
