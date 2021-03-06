class ValidateAreas < ActiveRecord::Migration[6.1]
  def change
  change_column :areas, :a_ID,         :string, null: false
  change_column :areas, :a_local_name, :string, null: false
  end
end
