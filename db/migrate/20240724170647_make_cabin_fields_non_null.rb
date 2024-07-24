class MakeCabinFieldsNonNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :cabins, :maxCapacity, false
    change_column_null :cabins, :regularPrice, false
    change_column_null :cabins, :name, false
    change_column_null :cabins, :image, false
    change_column_null :cabins, :description, false
  end
end
