class ChangeIsPaidDefaultInBookings < ActiveRecord::Migration[6.1]
  def change
    change_column_default :bookings, :is_paid, false
  end
end
