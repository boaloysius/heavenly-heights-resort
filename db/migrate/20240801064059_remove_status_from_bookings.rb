class RemoveStatusFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :status, :text
  end
end
