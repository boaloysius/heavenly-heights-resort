class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :fullName
      t.text :nationalID
      t.text :nationality
      t.text :countryFlag
      t.timestamps
    end
  end
end
