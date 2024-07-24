class AddUuidToCabins < ActiveRecord::Migration[7.1]
  def change
    # Enable UUID extension
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    
    # Adding UUID column with a default value
    add_column :cabins, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    # Ensure the UUID column is unique
    add_index :cabins, :uuid, unique: true

    # Optional: Set the UUID as the primary key
    # Note: This is complex and requires careful consideration of existing data and relationships.
    remove_column :cabins, :id
    rename_column :cabins, :uuid, :id
    execute "ALTER TABLE cabins ADD PRIMARY KEY (id);"
  end
end
