class AddRoleToUsersWithConstraint < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string, null: false, default: 'client'
    add_check_constraint :users, "role IN ('admin', 'client')", name: 'role_constraint'
  end
end
