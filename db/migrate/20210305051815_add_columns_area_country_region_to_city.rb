class AddColumnsAreaCountryRegionToCity < ActiveRecord::Migration[6.1]
  def change
    add_column :cities, :area_name,    :string, null: false
    add_column :cities, :country_name, :string, null: false
    add_column :cities, :region_name,  :string, null: false
  end
end
