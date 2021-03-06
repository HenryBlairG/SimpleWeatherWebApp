class ValidateRegions < ActiveRecord::Migration[6.1]
  def change
    change_column :regions, :r_ID,         :string, null: false
    change_column :regions, :r_local_name, :string, null: false
  end
end
