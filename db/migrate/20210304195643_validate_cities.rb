class ValidateCities < ActiveRecord::Migration[6.1]
  def change
  change_column :cities, :key,        :string,  null: false
  change_column :cities, :gmt,        :integer, null: false
  change_column :cities, :local_name, :string,  null: false
  end
end
