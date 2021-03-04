class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :c_ID
      t.string :c_local_name

      t.timestamps
    end
  end
end
