class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :num_nights, null: false
      t.integer :num_guests, null: false
      t.integer :cabin_price, null: false
      t.integer :extras_price, null: false
      t.integer :total_price, null: false
      t.uuid :cabin_id, null: false  # Changed to uuid
      t.boolean :has_breakfast, null: false
      t.boolean :is_paid, null: false
      t.text :status, null: false
      t.text :observations, null: true

      t.timestamps
    end

    add_foreign_key :bookings, :cabins, column: :cabin_id, primary_key: :id
  end
end
