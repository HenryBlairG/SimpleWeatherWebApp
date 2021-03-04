class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :key
      t.string :local_name
      t.integer :gmt

      t.timestamps
    end
  end
end
