class ValidateCountries < ActiveRecord::Migration[6.1]
  def change
  change_column :countries, :c_ID,         :string, null: false
  change_column :countries, :c_local_name, :string, null: false
  end
end
