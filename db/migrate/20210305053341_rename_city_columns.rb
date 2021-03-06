class RenameCityColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :cities, :country_name, :country
    rename_column :cities, :region_name,  :region
    rename_column :cities, :local_name,   :name
    rename_column :cities, :area_name,    :area
  end
end
