class CreateRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :regions do |t|
      t.string :r_ID
      t.string :r_local_name

      t.timestamps
    end
  end
end
