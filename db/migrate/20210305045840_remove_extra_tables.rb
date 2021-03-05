class RemoveExtraTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :regions
    drop_table :countries
    drop_table :areas
  end
end
