class ChangeStatusColumnTypeInBookings < ActiveRecord::Migration[6.1]
  def up
    change_column :bookings, :status, :text, null: false, default: 'booked'
  end

  def down
    change_column :bookings, :status, :integer, null: false, default: 0
  end
end
