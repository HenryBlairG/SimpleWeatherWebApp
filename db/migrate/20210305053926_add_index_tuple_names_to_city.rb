class AddIndexTupleNamesToCity < ActiveRecord::Migration[6.1]
  def change
    add_index :cities, [ :region, :country, :area, :name ], unique: true
  end
end
