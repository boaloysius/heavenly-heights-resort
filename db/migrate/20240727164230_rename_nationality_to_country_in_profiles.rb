class RenameNationalityToCountryInProfiles < ActiveRecord::Migration[6.0]
  def change
    rename_column :profiles, :nationality, :country
  end
end
