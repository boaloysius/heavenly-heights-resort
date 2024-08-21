class AddProfileImage < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :imageUrl, :string, null: false
    add_column :profiles, :imagePublicId, :string, null: false
  end
end
