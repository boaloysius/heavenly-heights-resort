class RenameNumNightsToNumDatesInBookings < ActiveRecord::Migration[7.1]
  def change
    rename_column :bookings, :num_nights, :num_dates
  end
end